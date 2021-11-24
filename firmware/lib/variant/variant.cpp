/*
  Copyright (c) 2014-2015 Arduino LLC.  All right reserved.

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

  Modified for the Flick by Allen Wild.
*/


#include "variant.h"

using namespace arduino;

/*
 * Pins descriptions
 */
const PinDescription g_APinDescription[] =
{
    // 0: Status/trigger LED. Can be TCC0/WO[2] for my PWM library, but don't use Arduino core's timer/pwm support.
    // Can also be used as AC/CMP[0], which will also be managed outside of the Arduino core code.
    { PORTA, 18, PIO_DIGITAL, PIN_ATTR_DIGITAL, No_ADC_Channel, NOT_ON_PWM, NOT_ON_TIMER, NOT_AN_INTERRUPT },   // LED_TRIG

    // 1-3: Rotary encoder pins. Digital inputs, interrupt-capable
    { PORTA, 12, PIO_DIGITAL, PIN_ATTR_DIGITAL, No_ADC_Channel, NOT_ON_PWM, NOT_ON_TIMER, EXTERNAL_INT_12 },    // ROT_PB
    { PORTB, 11, PIO_DIGITAL, PIN_ATTR_DIGITAL, No_ADC_Channel, NOT_ON_PWM, NOT_ON_TIMER, EXTERNAL_INT_11 },    // ROT_A
    { PORTB, 10, PIO_DIGITAL, PIN_ATTR_DIGITAL, No_ADC_Channel, NOT_ON_PWM, NOT_ON_TIMER, EXTERNAL_INT_10 },    // ROT_B

    // 4-6: OLED GPIO control pins
    { PORTA,  8, PIO_DIGITAL, PIN_ATTR_DIGITAL, No_ADC_Channel, NOT_ON_PWM, NOT_ON_TIMER, NOT_AN_INTERRUPT },   // OLED_DC
    { PORTA,  9, PIO_DIGITAL, PIN_ATTR_DIGITAL, No_ADC_Channel, NOT_ON_PWM, NOT_ON_TIMER, NOT_AN_INTERRUPT },   // OLED_RESET
    { PORTA, 10, PIO_DIGITAL, PIN_ATTR_DIGITAL, No_ADC_Channel, NOT_ON_PWM, NOT_ON_TIMER, NOT_AN_INTERRUPT },   // OLED_CS

    // 7-9: OLED SPI pins. MISO is not connected, but must be defined for the library code. SS (hardware chip-select) is not used.
    { PORTA, 16, PIO_SERCOM, PIN_ATTR_DIGITAL, No_ADC_Channel, NOT_ON_PWM, NOT_ON_TIMER, NOT_AN_INTERRUPT },   // OLED_MOSI, SERCOM1/PAD[0]
    { PORTA, 17, PIO_SERCOM, PIN_ATTR_DIGITAL, No_ADC_Channel, NOT_ON_PWM, NOT_ON_TIMER, NOT_AN_INTERRUPT },   // OLED_SCK, SERCOM1/PAD[1]
    { PORTA, 19, PIO_SERCOM, PIN_ATTR_DIGITAL, No_ADC_Channel, NOT_ON_PWM, NOT_ON_TIMER, NOT_AN_INTERRUPT },   // NC, SERCOM1/PAD[3]

    // 10-11: Analog pins
    { PORTA,  6, PIO_ANALOG, PIN_ATTR_ANALOG, ADC_Channel6, NOT_ON_PWM, NOT_ON_TIMER, NOT_AN_INTERRUPT },   // PHOTO_THRESH
    { PORTA,  7, PIO_ANALOG, PIN_ATTR_ANALOG, ADC_Channel7, NOT_ON_PWM, NOT_ON_TIMER, NOT_AN_INTERRUPT },   // PHOTO_VAL
};

const size_t g_APinDescriptionLength = sizeof(g_APinDescription) / sizeof(g_APinDescription[0]);

// Multi-serial objects instantiation
SERCOM sercom0(SERCOM0);
SERCOM sercom1(SERCOM1);
SERCOM sercom2(SERCOM2);
SERCOM sercom3(SERCOM3);
SERCOM sercom4(SERCOM4);
SERCOM sercom5(SERCOM5);
