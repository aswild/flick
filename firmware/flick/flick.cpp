/*
 * Firmware for the Flick (rev A)
 *
 * Copyright (c) 2021 Allen Wild
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#include "Arduino.h"
#include "Adafruit_SH110X.h"
#include "RotaryEncoder.h"
#include "SPI.h"

#include "util.h"

#define LED_DIRECT_ON_AC

static Adafruit_SH1106G display(128, 64, &SPI, PIN_OLED_DC, PIN_OLED_RESET, PIN_OLED_CS);
static RotaryEncoder encoder(PIN_ROT_B, PIN_ROT_A, RotaryEncoder::LatchMode::FOUR3);

static void encoder_irq()
{
    encoder.tick();
}

void AC_Handler()
{
#ifndef LED_DIRECT_ON_AC
    if (AC->INTFLAG.bit.COMP0)
    {
        if (AC->STATUSA.bit.STATE0)
            digitalWrite(PIN_LED_TRIG, HIGH);
        else
            digitalWrite(PIN_LED_TRIG, LOW);
    }
#endif
    AC->INTFLAG.reg = AC_INTFLAG_MASK;
}

void setup()
{
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

    pinMode(PIN_ROT_PB, INPUT_PULLUP);
#ifdef LED_DIRECT_ON_AC
    pinPeripheral(PIN_LED_TRIG, PIO_AC_CLK);
#else
    pinMode(PIN_LED_TRIG, OUTPUT);
#endif
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

    static int last_enc_pos = 0;
    if (!digitalRead(PIN_ROT_PB))
        encoder.setPosition(0);

    int enc_pos = encoder.getPosition();
    if (enc_pos != last_enc_pos) {
        last_enc_pos = enc_pos;
    }

    display.setCursor(0, 0);
    display.print(enc_pos);

    display.display();
    delay(100);
}
