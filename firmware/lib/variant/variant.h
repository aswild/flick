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
*/

#ifndef VARIANT_FLICK_H
#define VARIANT_FLICK_H

// The definitions here needs a SAMD core >=1.6.10
#define ARDUINO_SAMD_VARIANT_COMPLIANCE 10610
#define ARDUINO_ARCH_SAMD

/*----------------------------------------------------------------------------
 *        Definitions
 *----------------------------------------------------------------------------*/

/** Frequency of the board main oscillator */
#define VARIANT_MAINOSC		(32768ul)

/** Master clock frequency */
#define VARIANT_MCK			  (48000000ul)
#define F_CPU VARIANT_MCK

/*----------------------------------------------------------------------------
 *        Headers
 *----------------------------------------------------------------------------*/

#include "WVariant.h"

#ifdef __cplusplus
#include "SERCOM.h"
#include "Uart.h"
#endif // __cplusplus

#ifdef __cplusplus
extern "C"
{
#endif // __cplusplus

/*----------------------------------------------------------------------------
 *        Pins
 *----------------------------------------------------------------------------*/

// Number of pins defined in PinDescription array
#define PINS_COUNT           g_APinDescriptionLength
#define NUM_DIGITAL_PINS     10

#define digitalPinToPort(P)        ( &(PORT->Group[g_APinDescription[P].ulPort]) )
#define digitalPinToBitMask(P)     ( 1 << g_APinDescription[P].ulPin )
//#define analogInPinToBit(P)        ( )
#define portOutputRegister(port)   ( &(port->OUT.reg) )
#define portInputRegister(port)    ( &(port->IN.reg) )
#define portModeRegister(port)     ( &(port->DIR.reg) )
#define digitalPinHasPWM(P)        ( g_APinDescription[P].ulPWMChannel != NOT_ON_PWM || g_APinDescription[P].ulTCChannel != NOT_ON_TIMER )

// pin names
static const pin_size_t PIN_LED_TRIG    = 0;
static const pin_size_t PIN_ROT_PB      = 1;
static const pin_size_t PIN_ROT_A       = 2;
static const pin_size_t PIN_ROT_B       = 3;
static const pin_size_t PIN_OLED_DC     = 4;
static const pin_size_t PIN_OLED_RESET  = 5;
static const pin_size_t PIN_OLED_CS     = 6;
static const pin_size_t PIN_OLED_MOSI   = 7;
static const pin_size_t PIN_OLED_SCK    = 8;
static const pin_size_t PIN_NC_MISO     = 9;
static const pin_size_t PIN_PHOTO_THRESH = 10;
static const pin_size_t PIN_PHOTO_VAL   = 11;

// Other pins
#define PIN_ATN              (38ul)
static const uint8_t ATN = PIN_ATN;

/*
 * SPI Interfaces
 */
#define SPI_INTERFACES_COUNT 1
// Instead of using SERCOM4, and the SPI-header pins, the Mini Breakout
// uses pins 10-13 for SPI, on the unused sercom1
#define PIN_SPI_MISO    PIN_NC_MISO
#define PIN_SPI_MOSI    PIN_OLED_MOSI
#define PIN_SPI_SCK     PIN_OLED_SCK
#define PERIPH_SPI      sercom1
// Pad Map:     0       1   2     3
//          MOSI (TX)  SCK  SS  MOSI (RX)
#define PAD_SPI_TX SPI_PAD_0_SCK_1
#define PAD_SPI_RX SERCOM_RX_PAD_3

/*
 * Wire Interfaces
 */
#define WIRE_INTERFACES_COUNT 0
#if 0
#define PIN_WIRE_SDA         (20u)
#define PIN_WIRE_SCL         (21u)
#define PERIPH_WIRE          sercom3
#define WIRE_IT_HANDLER      SERCOM3_Handler
static const uint8_t SDA = PIN_WIRE_SDA;
static const uint8_t SCL = PIN_WIRE_SCL;
#endif

/*
 * USB
 */
//#define PIN_USB_HOST_ENABLE (27ul)
#define PIN_USB_DM          (28ul)
#define PIN_USB_DP          (29ul)

#define USB_MANUFACTURER    "SparkFun"
#define USB_PRODUCT         "SFE SAMD21"
#define USB_VID             0x1B4F
#define USB_PID             0x8D21

/*
 * I2S Interfaces
 */
#define I2S_INTERFACES_COUNT 0
#if 0
#define I2S_DEVICE          0
#define I2S_CLOCK_GENERATOR 3
#define PIN_I2S_SD          (9u)
#define PIN_I2S_SCK         (1u)
#define PIN_I2S_FS          (0u)
#endif

#ifdef __cplusplus
}
#endif

/*----------------------------------------------------------------------------
 *        Arduino objects - C++ only
 *----------------------------------------------------------------------------*/

#ifdef __cplusplus

/*	=========================
 *	===== SERCOM DEFINITION
 *	=========================
*/
extern SERCOM sercom0;
extern SERCOM sercom1;
extern SERCOM sercom2;
extern SERCOM sercom3;
extern SERCOM sercom4;
extern SERCOM sercom5;

#endif /* __cplusplus */

#endif /* VARIANT_FLICK_H */

