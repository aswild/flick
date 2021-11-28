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

#include "util.h"

static PWM pwm;
static int pwm_chan;

static Adafruit_SH1106G display(128, 64, &SPI, PIN_OLED_DC, PIN_OLED_RESET, PIN_OLED_CS);
static RotaryEncoder encoder(PIN_ROT_B, PIN_ROT_A, RotaryEncoder::LatchMode::FOUR3);

static void encoder_irq()
{
    encoder.tick();
}

void AC_Handler()
{
    if (AC->INTFLAG.bit.COMP0)
    {
        if (AC->STATUSA.bit.STATE0)
            pwm.set_width_us(pwm_chan, 50);
        else
            pwm.set_width_us(pwm_chan, 0);
    }
    AC->INTFLAG.reg = AC_INTFLAG_MASK;
}

void setup()
{
    //pinMode(10, OUTPUT);
    pwm.init();
    pwm_chan = pwm.enable_pin(PIN_LED_TRIG);
    if (pwm_chan == -1)
        while (1) {}

    pwm.start();

    flick_init_ac();

    display.begin(0, true);
    display.display();
    delay(1000); // display splash screen

    attachInterrupt(PIN_ROT_A, encoder_irq, CHANGE);
    attachInterrupt(PIN_ROT_B, encoder_irq, CHANGE);
    setInterruptFilter(PIN_ROT_A, true);
    setInterruptFilter(PIN_ROT_B, true);

    display.setTextColor(SH110X_WHITE);
    display.setTextSize(2);
}

static inline uint8_t analog_to_oled_y(int aval)
{
    return 63 - (aval >> 4);
}

void loop()
{
    static uint8_t values[128] = {0};
    static size_t pos = 0;

    int new_val = analogRead(PIN_PHOTO_VAL);
    values[pos++] = analog_to_oled_y(new_val);
    if (pos >= 128)
        pos = 0;

    int thresh = analogRead(PIN_PHOTO_THRESH);
    display.clearDisplay();
    display.writeFastHLine(0, analog_to_oled_y(thresh), 128, SH110X_WHITE);
    for (size_t i = 0; i < 128; i++)
    {
        size_t j = (i + pos) % 128;
        display.writePixel(i, values[j], SH110X_WHITE);
    }

    display.display();
    delay(100);
}

#if 0
void loop()
{
    static int last_pos = 0;
    static int dir = 0;
    int pos = encoder.getPosition();
    if (pos != last_pos) {
        last_pos = pos;
        dir = static_cast<int>(encoder.getDirection());
    }

    //int val = analogRead(PIN_PHOTO_THRESH);
    //pwm.set_chan(pwm_chan, val / 1024.0f, true);
    int val = analogRead(PIN_PHOTO_VAL);

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
#endif
