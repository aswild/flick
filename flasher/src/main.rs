//! The PC-side "flasher" application for Flick.
//! This is basically the simplest thing you can do with a hardware-accelerated 2D graphics system:
//! fill in everything with a solid color.
//!
//! There's a lot going on under the hood with pixels, winit, and wgpu, but the result is
//! GPU-accelerated surfaces and shaders and stuff (that I didn't have to mess with at all by hand
//! yay) and then a software rendered buffer provided by pixels for this program to fill in however
//! it wants.
//!
//! The goal here is to get minimum latency, hence all the wgpu stuff in the backend - we render to
//! a GPU surface (or whatever it's called) and hopefully bypass a lot of the OS' window compositor
//! or windowing systems, to the extent possible. My theory is that this setup is pretty similar to
//! how games probably render, so it's a reasonably real-world comparison for the latency that
//! Flick is intended to measure.

#![deny(clippy::all)]

use std::fmt;
use std::num::ParseIntError;
use std::str::FromStr;
use std::time::{Duration, Instant};

use anyhow::{Context, Result};
use clap::{AppSettings, Parser};
use pixels::{PixelsBuilder, SurfaceTexture};
use winit::dpi::LogicalSize;
use winit::event::{ElementState, Event, VirtualKeyCode, WindowEvent};
use winit::event_loop::{ControlFlow, EventLoop};
use winit::window::{Fullscreen, WindowBuilder};

const INITIAL_WIDTH: u32 = 500;
const INITIAL_HEIGHT: u32 = 500;

/// Run a closure and time how long it takes
fn time_func<F, T>(func: F) -> (T, Duration)
where
    F: FnOnce() -> T,
{
    let start = Instant::now();
    let ret = func();
    let duration = start.elapsed();
    (ret, duration)
}

/// Scale a size down by its GCD. Used to make the pixel buffer as small as possible and rely on
/// pixels' hardware scaling shader up to the full window size, rather than having to write a full
/// screen worth of pixels every time in software.
///
/// Doing this means that our draw() method completes in just a few dozen nanoseconds, rather than
/// a few hundred microseconds. However, this means that we're more inefficient if the window is
/// scaled to large uneven sizes, but the common case is fullscreen 16:9 resolution, only 144
/// pixels to write during the draw method.
///
/// I'm not sure how pixels' scaling shader works, but it seems to run faster when we have
/// a smaller framebuffer being scaled up, rather than a 1:1 buffer to surface size ratio.
///
/// All in all, on my computer with vsync off and fullscreen 1440p a frame is drawn and rendered in
/// just over 200us.
fn scale_by_gcd(width: u32, height: u32) -> (u32, u32) {
    /// Euclid's GCD algorithm, https://doc.rust-lang.org/std/ops/trait.Div.html
    fn get_gcd(mut x: u32, mut y: u32) -> u32 {
        while y != 0 {
            let t = y;
            y = x % y;
            x = t;
        }
        x
    }

    let gcd = get_gcd(width, height);
    (width / gcd, height / gcd)
}

/// Flash the screen for Flick measurements.
///
/// Hotkeys:
///     Space/Enter - Flash the screen from bgcolor to fgcolor
///     F           - Toggle Fullscreen (borderless window)
///     Q/Esc       - Quit
#[derive(Debug, Parser)]
#[clap(version, setting = AppSettings::DeriveDisplayOrder)]
struct Args {
    /// Start in fullscreen mode
    #[clap(short, long)]
    fullscreen: bool,

    /// Enable vsync (default is no vsync for low latency)
    #[clap(long)]
    vsync: bool,

    /// Background (inactive) color
    #[clap(long, default_value_t = Color::BLACK)]
    bgcolor: Color,

    /// Foreground (active) color
    #[clap(long, default_value_t = Color::WHITE)]
    fgcolor: Color,
}

/// Basically everything happens in main(). Not the prettiest, but it's the easiest to write
/// because of how winit's event loop works.
fn run() -> Result<()> {
    env_logger::init();
    let args = Args::parse();

    // setup the winit event loop and window
    let event_loop = EventLoop::new();
    let window = {
        let size = LogicalSize::new(INITIAL_WIDTH as f64, INITIAL_HEIGHT as f64);
        WindowBuilder::new()
            .with_title("Flick Flasher")
            .with_inner_size(size)
            .with_min_inner_size(size)
            .with_fullscreen(args.fullscreen.then(|| Fullscreen::Borderless(None)))
            .build(&event_loop)
            .context("Failed to initialize window")?
    };

    // set up the pixels context
    let mut pixels = {
        let window_size = window.inner_size();
        let surface_texture = SurfaceTexture::new(window_size.width, window_size.height, &window);
        let (px_width, px_height) = scale_by_gcd(window_size.width, window_size.height);
        PixelsBuilder::new(px_width, px_height, surface_texture)
            .enable_vsync(args.vsync) // this is passed on to wgpu
            .build()
            .context("Failed to initialize Pixels framebuffer")?
    };
    let mut state = State::new(args.bgcolor, args.fgcolor);

    // keep track of some timings
    let mut total_draw_time = 0u128;
    let mut total_render_time = 0u128;
    let mut draw_count = 0u64;
    let mut printed_stats = false;

    // note: this function hijacks the calling (main) thread and doesn't return.
    event_loop.run(move |event, _, control_flow| {
        match event {
            Event::RedrawRequested(_) => {
                // Draw the current frame
                let (_, draw_time) = time_func(|| state.draw(pixels.get_frame()));
                let (render_ret, render_time) = time_func(|| pixels.render());
                if let Err(err) = render_ret {
                    eprintln!("Error: pixels.render() failed: {}", err);
                    *control_flow = ControlFlow::Exit;
                    return;
                }

                total_draw_time += draw_time.as_nanos();
                total_render_time += render_time.as_nanos();
                draw_count += 1;
            }

            Event::WindowEvent { event: wev, .. } => match wev {
                WindowEvent::KeyboardInput { input, .. } => match input.virtual_keycode {
                    // Quit the application
                    Some(VirtualKeyCode::Escape | VirtualKeyCode::Q) => {
                        *control_flow = ControlFlow::Exit;
                    }

                    // Toggle bg/fg colors by holding spacebar or enter.
                    Some(VirtualKeyCode::Space | VirtualKeyCode::Return) => {
                        state.active = input.state == ElementState::Pressed
                    }

                    // F to toggle fullscreen. Use borderless window becuase exclusive fullscreen
                    // isn't supported on Wayland in winit, and because it means changing the
                    // monitor resolution, which gets weird sometimes.
                    Some(VirtualKeyCode::F) => match input.state {
                        ElementState::Pressed => match window.fullscreen() {
                            Some(_) => window.set_fullscreen(None),
                            None => window.set_fullscreen(Some(Fullscreen::Borderless(None))),
                        },
                        ElementState::Released => (),
                    },

                    // ignore other keys
                    _ => (),
                },

                WindowEvent::CloseRequested | WindowEvent::Destroyed => {
                    *control_flow = ControlFlow::Exit;
                }

                WindowEvent::Resized(size) => {
                    // Resize the pixels context when the window is scaled. The output surface size
                    // matches the window size. Pixels only supports integer scaling factors, so we
                    // make the buffer size the smallest multiple of the window size (i.e. divide
                    // the width and height by the GCD). Minimizing the buffer size makes our
                    // draw() method run faster since it has less data to write.
                    let (buf_width, buf_height) = scale_by_gcd(size.width, size.height);
                    eprintln!(
                        "resize to surface {}x{} buffer {}x{}",
                        size.width, size.height, buf_width, buf_height
                    );
                    pixels.resize_surface(size.width, size.height);
                    pixels.resize_buffer(buf_width, buf_height);
                }

                _ => (),
            }, // WindowEvent

            Event::MainEventsCleared => {
                // Done handling winit events, finally actually redraw the frame.
                // TODO: should this be timed in addition to state.draw() and pixels.render()?
                window.request_redraw();
            }

            _ => (),
        } // match event

        // If an event above requested an exit, print the stats
        if *control_flow == ControlFlow::Exit && !printed_stats {
            let avg_draw_time = (total_draw_time as f64 / (draw_count as f64)) / 1000.0;
            let avg_render_time = (total_render_time as f64 / (draw_count as f64)) / 1000.0;
            println!(
                "Average draw/render/total time (us) = {:.3} / {:.3} / {:.3}",
                avg_draw_time,
                avg_render_time,
                avg_draw_time + avg_render_time
            );
            // when exiting we get called several times where Exit is set, so use an extra flag to
            // only print the stats once.
            printed_stats = true;
        }
    }); // event_loop.run
}

fn main() {
    if let Err(err) = run() {
        eprintln!("Error: {:#?}", err);
        std::process::exit(1);
    }
}

/// The logical state of the flasher screen
#[derive(Debug)]
struct State {
    bg_color: Color,
    fg_color: Color,
    active: bool,
}

impl State {
    pub fn new(bg_color: Color, fg_color: Color) -> Self {
        Self { bg_color, fg_color, active: false }
    }

    /// Draw the state to the frame buffer.
    ///
    /// Assumes the default texture format: `wgpu::TextureFormat::Rgba8UnormSrgb`.
    #[inline(never)]
    fn draw(&self, frame: &mut [u8]) {
        let color_bytes =
            if self.active { self.fg_color.as_bytes() } else { self.bg_color.as_bytes() };

        // as of Rust 1.57, this is optimized by unrolling to 8 dword mov instructions per
        // iteration, but no SIMD vectorization that we could get from [u32].fill(), but this code
        // is so much simpler than the unsafe version that casts [u8] to [u32] soundly. Since we
        // minimize the size of the frame buffer, the speed tradeoff isn't worth it and stick with
        // the simple safe code.
        for chunk in frame.chunks_exact_mut(4) {
            chunk.copy_from_slice(&color_bytes);
        }
    }
}

/// An RGBA color, 8 bits per channel, stored in that order in memory.
#[derive(Debug, Clone, Copy, Eq, PartialEq)]
struct Color {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
}

impl fmt::Display for Color {
    /// Display the color as a 24-bit hex color.
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{:06X}", self.as_u32() >> 8)
    }
}

impl FromStr for Color {
    type Err = ParseIntError;

    /// Parse a 24-bit "hex color" string into a Color, e.g. "ffffff" is white and "ffff00" is
    /// yellow. A "0x" prefix is optional.
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        Ok(Self::new(u32::from_str_radix(s.strip_prefix("0x").unwrap_or(s), 16)?))
    }
}

impl Color {
    const BLACK: Color = Color::new(0x000000);
    const WHITE: Color = Color::new(0xffffff);

    /// Create a new Color from a 24-bit hex color
    const fn new(hexcolor: u32) -> Self {
        let bytes = ((hexcolor << 8) | 0xff).to_be_bytes();
        Self { r: bytes[0], g: bytes[1], b: bytes[2], a: bytes[3] }
    }

    /// Get the color as an RGBA byte array
    const fn as_bytes(&self) -> [u8; 4] {
        [self.r, self.g, self.b, self.a]
    }

    /// Get the color as a u32, with red in bits 24:31 and alpha in bits 0:7
    const fn as_u32(&self) -> u32 {
        u32::from_be_bytes(self.as_bytes())
    }
}
