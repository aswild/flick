#![deny(clippy::all)]
#![forbid(unsafe_code)]

use pixels::{Error, Pixels, SurfaceTexture};
use winit::dpi::LogicalSize;
use winit::event::{ElementState, Event, VirtualKeyCode, WindowEvent};
use winit::event_loop::{ControlFlow, EventLoop};
use winit::window::WindowBuilder;

#[cfg(feature = "logger")]
use log::error;

#[cfg(not(feature = "logger"))]
macro_rules! error {
    ($($arg:tt)+) => {{
        eprint!("ERROR: ");
        eprintln!($($arg)+);
    }};
}

const WIDTH: u32 = 320;
const HEIGHT: u32 = 240;
const BOX_SIZE: i16 = 64;

/// Representation of the application state. In this example, a box will bounce around the screen.
struct World {
    box_x: i16,
    box_y: i16,
    velocity_x: i16,
    velocity_y: i16,
    width: u32,
    height: u32,
    inverted: bool,
}

fn main() -> Result<(), Error> {
    #[cfg(feature = "logger")]
    env_logger::init();

    let event_loop = EventLoop::new();
    let window = {
        let size = LogicalSize::new(WIDTH as f64, HEIGHT as f64);
        WindowBuilder::new()
            .with_title("Hello Pixels")
            .with_inner_size(size)
            .with_min_inner_size(size)
            .build(&event_loop)
            .unwrap()
    };

    let mut pixels = {
        let window_size = window.inner_size();
        let surface_texture = SurfaceTexture::new(window_size.width, window_size.height, &window);
        Pixels::new(WIDTH, HEIGHT, surface_texture)?
    };
    let mut world = World::new();

    event_loop.run(move |event, _, control_flow| {
        match event {
            Event::RedrawRequested(_) => {
                // Draw the current frame
                world.draw(pixels.get_frame());
                if pixels.render().map_err(|e| error!("pixels.render() failed: {}", e)).is_err() {
                    *control_flow = ControlFlow::Exit;
                }
            }

            Event::WindowEvent { event: wev, .. } => match wev {
                WindowEvent::KeyboardInput { input, .. } => match input.virtual_keycode {
                    Some(VirtualKeyCode::Escape | VirtualKeyCode::Q) => {
                        *control_flow = ControlFlow::Exit;
                    }
                    Some(VirtualKeyCode::Space) => {
                        world.inverted = input.state == ElementState::Pressed
                    }
                    _ => (),
                },

                WindowEvent::CloseRequested | WindowEvent::Destroyed => {
                    *control_flow = ControlFlow::Exit;
                }

                WindowEvent::Resized(size) => {
                    pixels.resize_surface(size.width, size.height);
                    pixels.resize_buffer(size.width, size.height);
                    world.width = size.width;
                    world.height = size.height;
                }

                _ => (),
            }, // WindowEvent

            Event::MainEventsCleared => {
                world.update();
                window.request_redraw();
            }

            _ => (),
        } // match event
    }); // event_loop.run
}

impl World {
    /// Create a new `World` instance that can draw a moving box.
    fn new() -> Self {
        Self {
            box_x: 24,
            box_y: 16,
            velocity_x: 2,
            velocity_y: 2,
            inverted: false,
            width: WIDTH,
            height: HEIGHT,
        }
    }

    /// Update the `World` internal state; bounce the box around the screen.
    /// Also make sure the box stays in bounds, in case a window resize happened.
    fn update(&mut self) {
        if self.box_x <= 0 {
            self.velocity_x *= -1;
            self.box_x = 0;
        } else if self.box_x + BOX_SIZE > self.width as i16 {
            self.velocity_x *= -1;
            self.box_x = self.width as i16 - BOX_SIZE;
        }

        if self.box_y <= 0 {
            self.velocity_y *= -1;
            self.box_y = 0;
        } else if self.box_y + BOX_SIZE > self.height as i16 {
            self.velocity_y *= -1;
            self.box_y = self.height as i16 - BOX_SIZE;
        }

        self.box_x += self.velocity_x;
        self.box_y += self.velocity_y;
    }

    /// Draw the `World` state to the frame buffer.
    ///
    /// Assumes the default texture format: `wgpu::TextureFormat::Rgba8UnormSrgb`
    /// Faster version that fills the whole background first and then only the square
    fn draw(&self, frame: &mut [u8]) {
        use std::cmp::{max, min};

        let (fg, bg) = if self.inverted {
            ([0x48, 0xb2, 0xe8, 0xff], [0x5e, 0x48, 0xe8, 0xff])
        } else {
            ([0x5e, 0x48, 0xe8, 0xff], [0x48, 0xb2, 0xe8, 0xff])
        };

        // quickly fill the whole background
        for chunk in frame.chunks_exact_mut(4) {
            chunk.copy_from_slice(&bg);
        }

        // then update the box's pixels
        for x in max(self.box_x, 0)..min(self.box_x + BOX_SIZE, self.width as i16) {
            for y in max(self.box_y, 0)..min(self.box_y + BOX_SIZE, self.height as i16) {
                // cast up to usize; the range checks above ensure they're not negative
                let (x, y) = (x as usize, y as usize);
                // pixel index
                let pixel = y * self.width as usize + x;
                // byte index
                let idx = pixel * 4;
                frame[idx..(idx + 4)].copy_from_slice(&fg);
            }
        }
    }

    /// original draw method, which checks inside_the_box for every pixel
    fn _draw(&self, frame: &mut [u8]) {
        for (i, pixel) in frame.chunks_exact_mut(4).enumerate() {
            let x = (i % self.width as usize) as i16;
            let y = (i / self.width as usize) as i16;

            let inside_the_box = x >= self.box_x
                && x < self.box_x + BOX_SIZE
                && y >= self.box_y
                && y < self.box_y + BOX_SIZE;

            let rgba = if self.inverted ^ inside_the_box {
                [0x5e, 0x48, 0xe8, 0xff]
            } else {
                [0x48, 0xb2, 0xe8, 0xff]
            };

            pixel.copy_from_slice(&rgba);
        }
    }
}
