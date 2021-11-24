/*
 * Firmware for the Flick (rev A)
 *
 * Copyright (c) 2021 Allen Wild
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#include "Arduino.h"
#include "Adafruit_SH110X.h"
#include "PWM.h"
#include "RotaryEncoder.h"
#include "SPI.h"

static PWM pwm;
static int pwm_chan;

static Adafruit_SH1106G display(128, 64, &SPI, PIN_OLED_DC, PIN_OLED_RESET, PIN_OLED_CS);
static RotaryEncoder encoder(PIN_ROT_B, PIN_ROT_A, RotaryEncoder::LatchMode::FOUR3);

static void encoder_irq(void)
{
    encoder.tick();
}

void setup(void)
{
    //pinMode(10, OUTPUT);
    pwm.init();
    pwm_chan = pwm.enable_pin(PIN_LED_TRIG);
    if (pwm_chan == -1)
        while (1) {}

    pwm.start();

    display.begin(0, true);
    display.display();

    attachInterrupt(PIN_ROT_A, encoder_irq, CHANGE);
    attachInterrupt(PIN_ROT_B, encoder_irq, CHANGE);
    setInterruptFilter(PIN_ROT_A, true);
    setInterruptFilter(PIN_ROT_B, true);

    auto& d = display;
    d.setTextColor(SH110X_WHITE);
    d.setTextSize(2);
    // flip screen 180 degrees, as it sits on my desk more easily that way
    d.setRotation(2);
}

void loop(void)
{
    static int last_pos = 0;
    static int dir = 0;
    int pos = encoder.getPosition();
    if (pos != last_pos) {
        last_pos = pos;
        dir = static_cast<int>(encoder.getDirection());
    }

    int val = analogRead(PIN_PHOTO_THRESH);
    pwm.set_chan(pwm_chan, val / 1024.0f, true);

    auto& d = display;
    d.clearDisplay();
    d.setCursor(0, 0);
#if 0
    d.print(val);
    d.print('\n');
    d.print((val * 100) / 1024.0);
    d.print("%\n");
#else
    d.printf("%d\n%.1f%%\n", val, (val * 100.0) / 1024.0);
#endif

    d.printf("R: %d  %d", pos, dir);
    d.display();

    delay(10);
}
