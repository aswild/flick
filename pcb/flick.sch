EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Flick"
Date ""
Rev "A"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:USB_C_Receptacle_USB2.0 X1
U 1 1 61848F4A
P 1225 1625
F 0 "X1" H 875 2425 50  0000 C CNN
F 1 "USB_C_2.0" H 1075 2225 50  0000 C CNN
F 2 "Alkenta:USB_C_Receptacle_GCT_USB4105" H 1375 1625 50  0001 C CNN
F 3 "https://www.usb.org/sites/default/files/documents/usb_type-c.zip" H 1375 1625 50  0001 C CNN
	1    1225 1625
	1    0    0    -1  
$EndComp
Wire Wire Line
	1825 1525 1875 1525
Wire Wire Line
	1875 1525 1875 1625
Wire Wire Line
	1875 1625 1825 1625
Text GLabel 1925 1525 2    50   Input ~ 0
USB_D-
Text GLabel 1925 1725 2    50   Input ~ 0
USB_D+
Wire Wire Line
	1875 1525 1925 1525
Connection ~ 1875 1525
Wire Wire Line
	1925 1725 1875 1725
Wire Wire Line
	1825 1825 1875 1825
Wire Wire Line
	1875 1825 1875 1725
Connection ~ 1875 1725
Wire Wire Line
	1875 1725 1825 1725
NoConn ~ 1825 2125
NoConn ~ 1825 2225
Wire Wire Line
	2475 1375 2475 1325
Wire Wire Line
	2475 1325 1825 1325
Wire Wire Line
	1825 1225 2775 1225
Wire Wire Line
	2775 1225 2775 1375
$Comp
L power:GND #PWR0101
U 1 1 618570D4
P 2775 1675
F 0 "#PWR0101" H 2775 1425 50  0001 C CNN
F 1 "GND" H 2780 1502 50  0000 C CNN
F 2 "" H 2775 1675 50  0001 C CNN
F 3 "" H 2775 1675 50  0001 C CNN
	1    2775 1675
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0103
U 1 1 61857F89
P 2575 875
F 0 "#PWR0103" H 2575 725 50  0001 C CNN
F 1 "+5V" H 2590 1048 50  0000 C CNN
F 2 "" H 2575 875 50  0001 C CNN
F 3 "" H 2575 875 50  0001 C CNN
	1    2575 875 
	1    0    0    -1  
$EndComp
Wire Wire Line
	1825 1025 2275 1025
$Comp
L Device:R_Small R2
U 1 1 618616BD
P 2775 1475
F 0 "R2" H 2834 1521 50  0000 L CNN
F 1 "5.1K" H 2834 1430 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 2775 1475 50  0001 C CNN
F 3 "~" H 2775 1475 50  0001 C CNN
	1    2775 1475
	1    0    0    -1  
$EndComp
$Comp
L Device:Polyfuse_Small F1
U 1 1 61862E91
P 2375 1025
F 0 "F1" V 2170 1025 50  0000 C CNN
F 1 "500mA" V 2261 1025 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 2425 825 50  0001 L CNN
F 3 "~" H 2375 1025 50  0001 C CNN
	1    2375 1025
	0    1    1    0   
$EndComp
Wire Wire Line
	2475 1025 2575 1025
Wire Wire Line
	2575 875  2575 1025
Connection ~ 2575 1025
$Comp
L MCU_Microchip_SAMD:ATSAMD21G18A-AUT U1
U 1 1 6187ACF2
P 2550 5450
F 0 "U1" H 2550 5600 50  0000 C CNN
F 1 "ATSAMD21G18A-AFT" H 2550 5450 50  0000 C CNN
F 2 "Package_QFP:TQFP-48_7x7mm_P0.5mm" H 1600 3700 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/SAM_D21_DA1_Family_Data%20Sheet_DS40001882E.pdf" H 2550 6450 50  0001 C CNN
	1    2550 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 7350 2650 7400
Wire Wire Line
	2650 7400 2450 7400
Connection ~ 2450 7400
Wire Wire Line
	2450 7400 2450 7350
Wire Wire Line
	2450 7500 2450 7400
$Comp
L power:GND #PWR0104
U 1 1 61893FC4
P 2450 7500
F 0 "#PWR0104" H 2450 7250 50  0001 C CNN
F 1 "GND" H 2455 7327 50  0000 C CNN
F 2 "" H 2450 7500 50  0001 C CNN
F 3 "" H 2450 7500 50  0001 C CNN
	1    2450 7500
	1    0    0    -1  
$EndComp
Text GLabel 1550 6950 0    50   Input ~ 0
NRESET
$Comp
L power:+3.3V #PWR0105
U 1 1 6189A358
P 2350 3400
F 0 "#PWR0105" H 2350 3250 50  0001 C CNN
F 1 "+3.3V" H 2365 3573 50  0000 C CNN
F 2 "" H 2350 3400 50  0001 C CNN
F 3 "" H 2350 3400 50  0001 C CNN
	1    2350 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 3400 2350 3500
Wire Wire Line
	2450 3550 2450 3500
Wire Wire Line
	2450 3500 2350 3500
Connection ~ 2350 3500
Wire Wire Line
	2350 3500 2350 3550
Wire Wire Line
	3575 1025 3625 1025
Connection ~ 3575 1025
Wire Wire Line
	3575 1125 3575 1025
Wire Wire Line
	3625 1125 3575 1125
Connection ~ 4325 1025
Wire Wire Line
	4325 1125 4325 1025
$Comp
L Device:C_Small C2
U 1 1 6186FCCA
P 4325 1225
F 0 "C2" H 4417 1271 50  0000 L CNN
F 1 "10uF" H 4417 1180 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 4325 1225 50  0001 C CNN
F 3 "~" H 4325 1225 50  0001 C CNN
	1    4325 1225
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 6186F8CB
P 4325 1525
F 0 "#PWR0106" H 4325 1275 50  0001 C CNN
F 1 "GND" H 4330 1352 50  0000 C CNN
F 2 "" H 4325 1525 50  0001 C CNN
F 3 "" H 4325 1525 50  0001 C CNN
	1    4325 1525
	1    0    0    -1  
$EndComp
Wire Wire Line
	3425 1025 3575 1025
Connection ~ 3425 1025
Wire Wire Line
	3425 1175 3425 1025
$Comp
L Device:C_Small C1
U 1 1 6186CBF2
P 3425 1275
F 0 "C1" H 3517 1321 50  0000 L CNN
F 1 "1uF" H 3517 1230 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 3425 1275 50  0001 C CNN
F 3 "~" H 3425 1275 50  0001 C CNN
	1    3425 1275
	1    0    0    -1  
$EndComp
Wire Wire Line
	4325 1025 4325 975 
Wire Wire Line
	4225 1025 4325 1025
$Comp
L power:+3.3V #PWR0102
U 1 1 61839ECF
P 4325 975
F 0 "#PWR0102" H 4325 825 50  0001 C CNN
F 1 "+3.3V" H 4340 1148 50  0000 C CNN
F 2 "" H 4325 975 50  0001 C CNN
F 3 "" H 4325 975 50  0001 C CNN
	1    4325 975 
	1    0    0    -1  
$EndComp
$Comp
L Alkenta:AP2112M-3.3 U2
U 1 1 61838D89
P 3925 1125
F 0 "U2" H 3925 1467 50  0000 C CNN
F 1 "AP2112M-3.3" H 3925 1376 50  0000 C CNN
F 2 "Package_SO:SO-8_3.9x4.9mm_P1.27mm" H 3925 1450 50  0001 C CNN
F 3 "https://www.diodes.com/assets/Datasheets/AP2112.pdf" H 3925 1225 50  0001 C CNN
	1    3925 1125
	1    0    0    -1  
$EndComp
Text Notes 5950 1400 0    50   ~ 0
VDDIN
Text Notes 5550 1400 0    50   ~ 0
VDDIO
Wire Wire Line
	5500 2100 5700 2100
Wire Wire Line
	5150 2100 5300 2100
Wire Wire Line
	5150 2050 5150 2100
Wire Wire Line
	5700 2400 5700 2350
Wire Wire Line
	6050 2400 6050 2350
Wire Wire Line
	5700 2400 6050 2400
Wire Wire Line
	5700 2100 5700 2150
Connection ~ 5700 2100
Wire Wire Line
	6050 2100 5700 2100
Wire Wire Line
	6050 2150 6050 2100
$Comp
L Device:C_Small C7
U 1 1 618F79AC
P 5700 2250
F 0 "C7" H 5792 2296 50  0000 L CNN
F 1 "10uF" H 5792 2205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5700 2250 50  0001 C CNN
F 3 "~" H 5700 2250 50  0001 C CNN
	1    5700 2250
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C8
U 1 1 618F9C9B
P 6050 2250
F 0 "C8" H 6142 2296 50  0000 L CNN
F 1 "0.1uF" H 6142 2205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 6050 2250 50  0001 C CNN
F 3 "~" H 6050 2250 50  0001 C CNN
	1    6050 2250
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0107
U 1 1 618E948C
P 5150 2050
F 0 "#PWR0107" H 5150 1900 50  0001 C CNN
F 1 "+3.3V" H 5165 2223 50  0000 C CNN
F 2 "" H 5150 2050 50  0001 C CNN
F 3 "" H 5150 2050 50  0001 C CNN
	1    5150 2050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0108
U 1 1 618C2BE9
P 5900 1400
F 0 "#PWR0108" H 5900 1150 50  0001 C CNN
F 1 "GND" H 5905 1227 50  0000 C CNN
F 2 "" H 5900 1400 50  0001 C CNN
F 3 "" H 5900 1400 50  0001 C CNN
	1    5900 1400
	1    0    0    -1  
$EndComp
Text Notes 5200 1400 0    50   ~ 0
VDDIO
Connection ~ 5500 1400
Wire Wire Line
	5150 1400 5150 1350
Wire Wire Line
	5500 1400 5150 1400
Wire Wire Line
	5500 1400 5500 1350
Wire Wire Line
	5900 1400 5500 1400
Wire Wire Line
	5900 1400 5900 1350
Connection ~ 5500 1100
Wire Wire Line
	5900 1100 5900 1150
Wire Wire Line
	5500 1100 5900 1100
Wire Wire Line
	5150 1100 5150 1150
Connection ~ 5150 1100
Wire Wire Line
	5500 1100 5500 1150
Wire Wire Line
	5150 1100 5500 1100
Wire Wire Line
	5150 1000 5150 1100
$Comp
L power:+3.3V #PWR0109
U 1 1 618BF121
P 5150 1000
F 0 "#PWR0109" H 5150 850 50  0001 C CNN
F 1 "+3.3V" H 5165 1173 50  0000 C CNN
F 2 "" H 5150 1000 50  0001 C CNN
F 3 "" H 5150 1000 50  0001 C CNN
	1    5150 1000
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C6
U 1 1 618B1973
P 3200 3500
F 0 "C6" V 3250 3350 50  0000 L CNN
F 1 "1uF" V 3300 3450 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 3200 3500 50  0001 C CNN
F 3 "~" H 3200 3500 50  0001 C CNN
	1    3200 3500
	0    -1   -1   0   
$EndComp
$Comp
L Device:C_Small C5
U 1 1 618B139E
P 5900 1250
F 0 "C5" H 5992 1296 50  0000 L CNN
F 1 "0.1uF" H 5992 1205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 5900 1250 50  0001 C CNN
F 3 "~" H 5900 1250 50  0001 C CNN
	1    5900 1250
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C4
U 1 1 618B0B76
P 5500 1250
F 0 "C4" H 5592 1296 50  0000 L CNN
F 1 "0.1uF" H 5592 1205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 5500 1250 50  0001 C CNN
F 3 "~" H 5500 1250 50  0001 C CNN
	1    5500 1250
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C3
U 1 1 6189D708
P 5150 1250
F 0 "C3" H 5242 1296 50  0000 L CNN
F 1 "0.1uF" H 5242 1205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 5150 1250 50  0001 C CNN
F 3 "~" H 5150 1250 50  0001 C CNN
	1    5150 1250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0110
U 1 1 6184DCC0
P 1225 2575
F 0 "#PWR0110" H 1225 2325 50  0001 C CNN
F 1 "GND" H 1230 2402 50  0000 C CNN
F 2 "" H 1225 2575 50  0001 C CNN
F 3 "" H 1225 2575 50  0001 C CNN
	1    1225 2575
	1    0    0    -1  
$EndComp
Text Notes 4925 675  0    79   ~ 0
Decoupling and Filtering
Text Notes 900  700  0    79   ~ 0
USB and Power Supply
Wire Wire Line
	2575 1025 3425 1025
$Comp
L Device:Crystal_Small Y1
U 1 1 6199EAC6
P 1150 3900
F 0 "Y1" V 1000 3900 50  0000 C CNN
F 1 "32.768KHz" V 1300 3900 50  0000 C CNN
F 2 "Crystal:Crystal_SMD_MicroCrystal_CC8V-T1A-2Pin_2.0x1.2mm_HandSoldering" H 1150 3900 50  0001 C CNN
F 3 "~" H 1150 3900 50  0001 C CNN
	1    1150 3900
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR0111
U 1 1 619D1514
P 8200 1325
F 0 "#PWR0111" H 8200 1175 50  0001 C CNN
F 1 "+3.3V" H 8215 1498 50  0000 C CNN
F 2 "" H 8200 1325 50  0001 C CNN
F 3 "" H 8200 1325 50  0001 C CNN
	1    8200 1325
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 1525 8200 1575
Connection ~ 8200 1575
$Comp
L Device:R_Small R6
U 1 1 619D204A
P 8200 1425
F 0 "R6" H 8259 1471 50  0000 L CNN
F 1 "10K" H 8259 1380 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 8200 1425 50  0001 C CNN
F 3 "~" H 8200 1425 50  0001 C CNN
	1    8200 1425
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0112
U 1 1 619E5B58
P 8200 2075
F 0 "#PWR0112" H 8200 1825 50  0001 C CNN
F 1 "GND" H 8205 1902 50  0000 C CNN
F 2 "" H 8200 2075 50  0001 C CNN
F 3 "" H 8200 2075 50  0001 C CNN
	1    8200 2075
	1    0    0    -1  
$EndComp
Text GLabel 1550 6650 0    50   Input ~ 0
SWCLK
Text GLabel 1550 6750 0    50   Input ~ 0
SWDIO
$Comp
L power:GND #PWR0113
U 1 1 61A1F91F
P 9775 2325
F 0 "#PWR0113" H 9775 2075 50  0001 C CNN
F 1 "GND" H 9780 2152 50  0000 C CNN
F 2 "" H 9775 2325 50  0001 C CNN
F 3 "" H 9775 2325 50  0001 C CNN
	1    9775 2325
	1    0    0    -1  
$EndComp
NoConn ~ 9675 2325
NoConn ~ 10275 1925
NoConn ~ 10275 1825
Text GLabel 10275 1725 2    50   Input ~ 0
SWDIO
Text GLabel 10275 1625 2    50   Input ~ 0
SWCLK
Text GLabel 10275 1425 2    50   Input ~ 0
NRESET
$Comp
L Connector:Conn_ARM_JTAG_SWD_10 J1
U 1 1 61A02C65
P 9775 1725
F 0 "J1" H 9475 2275 50  0000 R CNN
F 1 "DEBUG" H 9625 2125 50  0000 R CNN
F 2 "Connector_PinHeader_1.27mm:PinHeader_2x05_P1.27mm_Vertical_SMD" H 9775 1725 50  0001 C CNN
F 3 "http://infocenter.arm.com/help/topic/com.arm.doc.ddi0314h/DDI0314H_coresight_components_trm.pdf" V 9425 475 50  0001 C CNN
	1    9775 1725
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0114
U 1 1 61A0055A
P 9775 1125
F 0 "#PWR0114" H 9775 975 50  0001 C CNN
F 1 "+3.3V" H 9790 1298 50  0000 C CNN
F 2 "" H 9775 1125 50  0001 C CNN
F 3 "" H 9775 1125 50  0001 C CNN
	1    9775 1125
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3VA #PWR0115
U 1 1 6184041E
P 2650 3400
F 0 "#PWR0115" H 2650 3250 50  0001 C CNN
F 1 "+3.3VA" H 2665 3573 50  0000 C CNN
F 2 "" H 2650 3400 50  0001 C CNN
F 3 "" H 2650 3400 50  0001 C CNN
	1    2650 3400
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3VA #PWR0116
U 1 1 6184DBB2
P 6050 2050
F 0 "#PWR0116" H 6050 1900 50  0001 C CNN
F 1 "+3.3VA" H 6065 2223 50  0000 C CNN
F 2 "" H 6050 2050 50  0001 C CNN
F 3 "" H 6050 2050 50  0001 C CNN
	1    6050 2050
	1    0    0    -1  
$EndComp
Connection ~ 6050 2100
Wire Wire Line
	6050 2050 6050 2100
$Comp
L power:GND #PWR0117
U 1 1 618E9FC9
P 6050 2450
F 0 "#PWR0117" H 6050 2200 50  0001 C CNN
F 1 "GND" H 6055 2277 50  0000 C CNN
F 2 "" H 6050 2450 50  0001 C CNN
F 3 "" H 6050 2450 50  0001 C CNN
	1    6050 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 2450 6050 2400
Connection ~ 6050 2400
$Comp
L Device:Ferrite_Bead_Small FB1
U 1 1 618EA874
P 5400 2100
F 0 "FB1" V 5250 2100 50  0000 C CNN
F 1 "50ohm @ 20MHz" V 5500 2000 50  0000 C CNN
F 2 "Inductor_SMD:L_0805_2012Metric_Pad1.05x1.20mm_HandSolder" V 5330 2100 50  0001 C CNN
F 3 "~" H 5400 2100 50  0001 C CNN
	1    5400 2100
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R5
U 1 1 618B485D
P 7950 1575
F 0 "R5" V 7850 1525 50  0000 L CNN
F 1 "330R" V 8050 1475 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 7950 1575 50  0001 C CNN
F 3 "~" H 7950 1575 50  0001 C CNN
	1    7950 1575
	0    1    1    0   
$EndComp
Wire Wire Line
	7850 1575 7750 1575
Wire Wire Line
	8050 1575 8200 1575
Wire Wire Line
	7750 1975 7750 2025
Connection ~ 8200 2025
Wire Wire Line
	8200 2075 8200 2025
Wire Wire Line
	7750 2025 8200 2025
Wire Wire Line
	8200 1925 8200 2025
Wire Wire Line
	8200 1725 8200 1575
$Comp
L Device:C_Small C11
U 1 1 618AB9F5
P 8200 1825
F 0 "C11" H 8292 1871 50  0000 L CNN
F 1 "0.1uF" H 8292 1780 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 8200 1825 50  0001 C CNN
F 3 "~" H 8200 1825 50  0001 C CNN
	1    8200 1825
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 1575 8200 1575
Text GLabel 8350 1575 2    50   Input ~ 0
NRESET
Wire Wire Line
	1550 3850 1500 3850
Wire Wire Line
	1500 3850 1500 3800
Wire Wire Line
	1500 3800 1150 3800
Wire Wire Line
	1550 3950 1500 3950
Wire Wire Line
	1500 3950 1500 4000
Wire Wire Line
	1500 4000 1150 4000
Wire Wire Line
	950  3800 1150 3800
Connection ~ 1150 3800
Wire Wire Line
	950  4000 1150 4000
Connection ~ 1150 4000
$Comp
L power:GND #PWR0118
U 1 1 61913AAC
P 650 4100
F 0 "#PWR0118" H 650 3850 50  0001 C CNN
F 1 "GND" H 655 3927 50  0000 C CNN
F 2 "" H 650 4100 50  0001 C CNN
F 3 "" H 650 4100 50  0001 C CNN
	1    650  4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	650  4100 650  4000
Wire Wire Line
	650  3800 750  3800
Wire Wire Line
	750  4000 650  4000
Connection ~ 650  4000
Wire Wire Line
	650  4000 650  3800
$Comp
L Device:C_Small C10
U 1 1 619BA2DB
P 850 4000
F 0 "C10" V 800 3800 50  0000 L CNN
F 1 "15pF" V 950 3900 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 850 4000 50  0001 C CNN
F 3 "~" H 850 4000 50  0001 C CNN
	1    850  4000
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C9
U 1 1 619B4189
P 850 3800
F 0 "C9" V 900 3650 50  0000 L CNN
F 1 "15pF" V 750 3700 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 850 3800 50  0001 C CNN
F 3 "~" H 850 3800 50  0001 C CNN
	1    850  3800
	0    1    1    0   
$EndComp
Text GLabel 1550 6250 0    50   Input ~ 0
USB_D-
Text GLabel 1550 6350 0    50   Input ~ 0
USB_D+
Wire Wire Line
	2775 1575 2775 1625
Wire Wire Line
	2475 1575 2475 1625
Wire Wire Line
	2475 1625 2775 1625
Connection ~ 2775 1625
Wire Wire Line
	2775 1625 2775 1675
Wire Wire Line
	4325 1325 4325 1475
Wire Wire Line
	4325 1475 3925 1475
Wire Wire Line
	3425 1475 3425 1375
Wire Wire Line
	3925 1425 3925 1475
Connection ~ 3925 1475
Wire Wire Line
	3925 1475 3425 1475
Wire Wire Line
	4325 1525 4325 1475
Connection ~ 4325 1475
$Comp
L Device:Q_Photo_NPN Q1
U 1 1 619646AD
P 4695 3975
F 0 "Q1" H 4885 4021 50  0000 L CNN
F 1 "Q_Photo_NPN" H 4885 3930 50  0000 L CNN
F 2 "LED_THT:LED_D5.0mm" H 4895 4075 50  0001 C CNN
F 3 "~" H 4695 3975 50  0001 C CNN
	1    4695 3975
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3VA #PWR0119
U 1 1 61965152
P 4795 3675
F 0 "#PWR0119" H 4795 3525 50  0001 C CNN
F 1 "+3.3VA" H 4810 3848 50  0000 C CNN
F 2 "" H 4795 3675 50  0001 C CNN
F 3 "" H 4795 3675 50  0001 C CNN
	1    4795 3675
	1    0    0    -1  
$EndComp
Wire Wire Line
	4795 3675 4795 3775
Wire Wire Line
	4795 4175 4795 4225
Text GLabel 4945 4225 2    50   Input ~ 0
PHOTO_VAL
Wire Wire Line
	4945 4225 4795 4225
$Comp
L power:GND #PWR0120
U 1 1 619828B5
P 5845 4225
F 0 "#PWR0120" H 5845 3975 50  0001 C CNN
F 1 "GND" H 5850 4052 50  0000 C CNN
F 2 "" H 5845 4225 50  0001 C CNN
F 3 "" H 5845 4225 50  0001 C CNN
	1    5845 4225
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3VA #PWR0121
U 1 1 61982BD2
P 5845 3925
F 0 "#PWR0121" H 5845 3775 50  0001 C CNN
F 1 "+3.3VA" H 5860 4098 50  0000 C CNN
F 2 "" H 5845 3925 50  0001 C CNN
F 3 "" H 5845 3925 50  0001 C CNN
	1    5845 3925
	1    0    0    -1  
$EndComp
Text GLabel 6045 4075 2    50   Input ~ 0
PHOTO_THRESH
Wire Wire Line
	6045 4075 5995 4075
Text Notes 5250 2500 0    50   ~ 0
Place near GNDANA
Text GLabel 1550 4450 0    50   Input ~ 0
PHOTO_THRESH
Text GLabel 1550 4550 0    50   Input ~ 0
PHOTO_VAL
Text Notes 4175 3225 0    79   ~ 0
Phototransistor Analog
$Comp
L Device:R_POT VR2
U 1 1 61981953
P 5845 4075
F 0 "VR2" H 5775 4029 50  0000 R CNN
F 1 "10K" H 5775 4120 50  0000 R CNN
F 2 "Alkenta:Potentiometer_Bourns_PTV09A-1_Single_Vertical" H 5845 4075 50  0001 C CNN
F 3 "~" H 5845 4075 50  0001 C CNN
	1    5845 4075
	1    0    0    1   
$EndComp
Connection ~ 4795 4225
NoConn ~ 4645 4325
Wire Wire Line
	4795 4225 4795 4475
$Comp
L power:GND #PWR0122
U 1 1 6196CC7A
P 4645 4625
F 0 "#PWR0122" H 4645 4375 50  0001 C CNN
F 1 "GND" H 4650 4452 50  0000 C CNN
F 2 "" H 4645 4625 50  0001 C CNN
F 3 "" H 4645 4625 50  0001 C CNN
	1    4645 4625
	1    0    0    -1  
$EndComp
$Comp
L Device:R_POT VR1
U 1 1 61991BD2
P 4645 4475
F 0 "VR1" H 4575 4429 50  0000 R CNN
F 1 "10K" H 4575 4520 50  0000 R CNN
F 2 "Alkenta:Potentiometer_Bourns_PTV09A-1_Single_Vertical" H 4645 4475 50  0001 C CNN
F 3 "~" H 4645 4475 50  0001 C CNN
	1    4645 4475
	1    0    0    1   
$EndComp
$Comp
L Switch:SW_Push SW2
U 1 1 619D09FB
P 7750 1775
F 0 "SW2" V 7704 1923 50  0000 L CNN
F 1 "RESET" V 7795 1923 50  0000 L CNN
F 2 "Button_Switch_SMD:SW_SPST_PTS645" H 7750 1975 50  0001 C CNN
F 3 "~" H 7750 1975 50  0001 C CNN
	1    7750 1775
	0    -1   -1   0   
$EndComp
$Comp
L Alkenta:SH1106G X2
U 1 1 61855B25
P 8250 4325
F 0 "X2" H 8250 5000 50  0000 C CNN
F 1 "SH1106G" H 8250 4909 50  0000 C CNN
F 2 "Alkenta:GCT_FFC2B28-16_1x16-1MP_P0.5mm_Horizontal" H 7950 4575 50  0001 C CNN
F 3 "" H 7950 4575 50  0001 C CNN
	1    8250 4325
	1    0    0    -1  
$EndComp
Text GLabel 7800 4125 0    50   Input ~ 0
OLED_CS
Text GLabel 7800 4225 0    50   Input ~ 0
OLED_DC
Text GLabel 7800 4325 0    50   Input ~ 0
OLED_SCK
Text GLabel 7800 4425 0    50   Input ~ 0
OLED_MOSI
$Comp
L Device:R_Small R4
U 1 1 6187A8B2
P 7350 4025
F 0 "R4" V 7250 4025 50  0000 C CNN
F 1 "5.1K" V 7350 4025 39  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 7350 4025 50  0001 C CNN
F 3 "~" H 7350 4025 50  0001 C CNN
	1    7350 4025
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0123
U 1 1 6187B69E
P 7200 4075
F 0 "#PWR0123" H 7200 3825 50  0001 C CNN
F 1 "GND" H 7205 3902 50  0000 C CNN
F 2 "" H 7200 4075 50  0001 C CNN
F 3 "" H 7200 4075 50  0001 C CNN
	1    7200 4075
	1    0    0    -1  
$EndComp
Wire Wire Line
	7450 4025 7600 4025
Text GLabel 7600 3975 1    50   Input ~ 0
OLED_RESET
Wire Wire Line
	7600 3975 7600 4025
Connection ~ 7600 4025
Wire Wire Line
	7600 4025 7800 4025
$Comp
L power:GND #PWR0124
U 1 1 61884979
P 8250 4925
F 0 "#PWR0124" H 8250 4675 50  0001 C CNN
F 1 "GND" H 8255 4752 50  0000 C CNN
F 2 "" H 8250 4925 50  0001 C CNN
F 3 "" H 8250 4925 50  0001 C CNN
	1    8250 4925
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R7
U 1 1 6188C884
P 8800 4325
F 0 "R7" V 8825 4200 39  0000 C CNN
F 1 "680K" V 8800 4325 31  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 8800 4325 50  0001 C CNN
F 3 "~" H 8800 4325 50  0001 C CNN
	1    8800 4325
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8700 3825 8800 3825
Wire Wire Line
	8800 3825 8800 3775
$Comp
L power:+3.3V #PWR0125
U 1 1 61893A2F
P 8800 3775
F 0 "#PWR0125" H 8800 3625 50  0001 C CNN
F 1 "+3.3V" H 8815 3948 50  0000 C CNN
F 2 "" H 8800 3775 50  0001 C CNN
F 3 "" H 8800 3775 50  0001 C CNN
	1    8800 3775
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0126
U 1 1 618ADF3B
P 9150 4375
F 0 "#PWR0126" H 9150 4125 50  0001 C CNN
F 1 "GND" H 9155 4202 50  0000 C CNN
F 2 "" H 9150 4375 50  0001 C CNN
F 3 "" H 9150 4375 50  0001 C CNN
	1    9150 4375
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C15
U 1 1 618892E4
P 8800 4675
F 0 "C15" V 8750 4750 39  0000 C CNN
F 1 "1uF" V 8850 4775 39  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 8800 4675 50  0001 C CNN
F 3 "~" H 8800 4675 50  0001 C CNN
	1    8800 4675
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C14
U 1 1 6188533A
P 8800 4475
F 0 "C14" V 8750 4550 39  0000 C CNN
F 1 "1uF" V 8850 4575 39  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 8800 4475 50  0001 C CNN
F 3 "~" H 8800 4475 50  0001 C CNN
	1    8800 4475
	0    1    1    0   
$EndComp
Wire Wire Line
	9000 4575 9000 4475
Wire Wire Line
	9000 4475 8900 4475
Wire Wire Line
	8700 4575 9000 4575
Wire Wire Line
	8900 4675 9000 4675
Wire Wire Line
	9000 4675 9000 4775
Wire Wire Line
	8700 4775 9000 4775
$Comp
L Device:C_Small C13
U 1 1 618EA4C7
P 8800 4175
F 0 "C13" V 8750 4250 39  0000 C CNN
F 1 "10uF" V 8825 4275 39  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 8800 4175 50  0001 C CNN
F 3 "~" H 8800 4175 50  0001 C CNN
	1    8800 4175
	0    1    1    0   
$EndComp
Wire Wire Line
	8700 3925 8800 3925
Wire Wire Line
	8800 3925 8800 3825
Connection ~ 8800 3825
Wire Wire Line
	8900 4325 9150 4325
Wire Wire Line
	9150 4325 9150 4375
Wire Wire Line
	8900 4175 9150 4175
Wire Wire Line
	9150 4175 9150 4325
Connection ~ 9150 4325
Wire Wire Line
	9150 4025 9150 4175
Connection ~ 9150 4175
$Comp
L Device:C_Small C12
U 1 1 61904450
P 8800 4025
F 0 "C12" V 8750 4100 39  0000 C CNN
F 1 "10uF" V 8825 4125 39  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 8800 4025 50  0001 C CNN
F 3 "~" H 8800 4025 50  0001 C CNN
	1    8800 4025
	0    1    1    0   
$EndComp
Wire Wire Line
	7200 4075 7200 4025
Wire Wire Line
	7200 4025 7250 4025
$Comp
L Device:LED D1
U 1 1 6194F255
P 4950 6100
F 0 "D1" V 4989 5982 50  0000 R CNN
F 1 "LED" V 4898 5982 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 4950 6100 50  0001 C CNN
F 3 "~" H 4950 6100 50  0001 C CNN
	1    4950 6100
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small R3
U 1 1 61950AAC
P 4950 5850
F 0 "R3" H 5009 5896 50  0000 L CNN
F 1 "330R" H 5009 5805 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 4950 5850 50  0001 C CNN
F 3 "~" H 4950 5850 50  0001 C CNN
	1    4950 5850
	1    0    0    -1  
$EndComp
Text GLabel 4650 6450 0    50   Input ~ 0
LED_TRIG
Text GLabel 1550 5450 0    50   Input ~ 0
OLED_MOSI
Text GLabel 1550 5550 0    50   Input ~ 0
OLED_SCK
Text GLabel 1550 4850 0    50   Input ~ 0
OLED_CS
Text GLabel 1550 4650 0    50   Input ~ 0
OLED_DC
Text GLabel 1550 4750 0    50   Input ~ 0
OLED_RESET
$Comp
L power:+3.3V #PWR0127
U 1 1 619CC6B0
P 4950 5750
F 0 "#PWR0127" H 4950 5600 50  0001 C CNN
F 1 "+3.3V" H 4965 5923 50  0000 C CNN
F 2 "" H 4950 5750 50  0001 C CNN
F 3 "" H 4950 5750 50  0001 C CNN
	1    4950 5750
	1    0    0    -1  
$EndComp
$Comp
L Device:Rotary_Encoder_Switch SW1
U 1 1 619D190F
P 6225 6075
F 0 "SW1" H 6225 6350 50  0000 C CNN
F 1 "Rotary_Encoder_Switch" H 6225 6351 50  0001 C CNN
F 2 "Alkenta:RotaryEncoder_Bourns_PEC11L-Switch_Vertical_H20mm" H 6075 6235 50  0001 C CNN
F 3 "~" H 6225 6335 50  0001 C CNN
	1    6225 6075
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0128
U 1 1 619D35B3
P 6575 6225
F 0 "#PWR0128" H 6575 5975 50  0001 C CNN
F 1 "GND" H 6580 6052 50  0000 C CNN
F 2 "" H 6575 6225 50  0001 C CNN
F 3 "" H 6575 6225 50  0001 C CNN
	1    6575 6225
	1    0    0    -1  
$EndComp
Wire Wire Line
	6525 6175 6575 6175
Wire Wire Line
	6575 6175 6575 6225
$Comp
L power:GND #PWR0129
U 1 1 619DAD22
P 5925 6075
F 0 "#PWR0129" H 5925 5825 50  0001 C CNN
F 1 "GND" V 5930 5902 50  0000 C CNN
F 2 "" H 5925 6075 50  0001 C CNN
F 3 "" H 5925 6075 50  0001 C CNN
	1    5925 6075
	0    1    1    0   
$EndComp
Text GLabel 5925 5975 0    50   Input ~ 0
ROT_A
Text GLabel 5925 6175 0    50   Input ~ 0
ROT_B
Text GLabel 6525 5975 2    50   Input ~ 0
ROT_PB
Text GLabel 3550 4350 2    50   Input ~ 0
ROT_A
Text GLabel 3550 4250 2    50   Input ~ 0
ROT_B
Text GLabel 1550 5050 0    50   Input ~ 0
ROT_PB
Text GLabel 1550 5650 0    50   Input ~ 0
LED_TRIG
$Comp
L Device:R_Small R1
U 1 1 6185DFD7
P 2475 1475
F 0 "R1" H 2534 1521 50  0000 L CNN
F 1 "5.1K" H 2534 1430 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.98x0.95mm_HandSolder" H 2475 1475 50  0001 C CNN
F 3 "~" H 2475 1475 50  0001 C CNN
	1    2475 1475
	1    0    0    -1  
$EndComp
Text Notes 4200 5200 0    79   ~ 0
User Interface
Text Notes 7375 675  0    79   ~ 0
Reset and Debug
Text Notes 7050 3175 0    79   ~ 0
OLED Screen
NoConn ~ 1550 4050
NoConn ~ 1550 4150
NoConn ~ 1550 4250
NoConn ~ 1550 4350
NoConn ~ 1550 4950
NoConn ~ 1550 5250
NoConn ~ 1550 5350
NoConn ~ 1550 5750
NoConn ~ 1550 6050
NoConn ~ 1550 6150
NoConn ~ 1550 6450
NoConn ~ 1550 6550
NoConn ~ 3550 3850
NoConn ~ 3550 3950
NoConn ~ 3550 4050
NoConn ~ 3550 4150
NoConn ~ 3550 4450
NoConn ~ 3550 4550
Connection ~ 5900 1400
$Comp
L power:GND #PWR0130
U 1 1 61B17AEF
P 3300 3500
F 0 "#PWR0130" H 3300 3250 50  0001 C CNN
F 1 "GND" H 3305 3327 50  0000 C CNN
F 2 "" H 3300 3500 50  0001 C CNN
F 3 "" H 3300 3500 50  0001 C CNN
	1    3300 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2750 3500 2750 3550
Wire Wire Line
	2650 3400 2650 3550
Wire Wire Line
	8900 4025 9150 4025
Wire Notes Line style solid
	475  2975 11225 2975
Wire Notes Line style solid
	4775 475  4775 2975
Wire Wire Line
	925  2525 925  2575
Wire Wire Line
	925  2575 1225 2575
Wire Wire Line
	1225 2575 1225 2525
Connection ~ 1225 2575
Text Notes 650  3200 0    79   ~ 0
SAMD21G
Wire Notes Line style solid
	4100 2975 4100 7800
Wire Notes Line style solid
	6970 6540 6970 475 
Wire Notes Line style solid
	4105 4985 6970 4985
Text Label 1850 1025 0    50   ~ 0
VBUS_RAW
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 619B2F97
P 10425 4050
F 0 "H1" V 10425 4250 50  0000 C CNN
F 1 "MountingHole_Pad" V 10571 4053 50  0001 C CNN
F 2 "MountingHole:MountingHole_5mm_Pad" H 10425 4050 50  0001 C CNN
F 3 "~" H 10425 4050 50  0001 C CNN
	1    10425 4050
	0    -1   -1   0   
$EndComp
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 619BA677
P 10425 4225
F 0 "H2" V 10425 4425 50  0000 C CNN
F 1 "MountingHole_Pad" V 10571 4228 50  0001 C CNN
F 2 "MountingHole:MountingHole_5mm_Pad" H 10425 4225 50  0001 C CNN
F 3 "~" H 10425 4225 50  0001 C CNN
	1    10425 4225
	0    -1   -1   0   
$EndComp
$Comp
L Mechanical:MountingHole_Pad H3
U 1 1 619BAAAD
P 10425 4400
F 0 "H3" V 10425 4600 50  0000 C CNN
F 1 "MountingHole_Pad" V 10571 4403 50  0001 C CNN
F 2 "MountingHole:MountingHole_5mm_Pad" H 10425 4400 50  0001 C CNN
F 3 "~" H 10425 4400 50  0001 C CNN
	1    10425 4400
	0    -1   -1   0   
$EndComp
$Comp
L Mechanical:MountingHole_Pad H4
U 1 1 619BAEA6
P 10425 4575
F 0 "H4" V 10425 4775 50  0000 C CNN
F 1 "MountingHole_Pad" V 10571 4578 50  0001 C CNN
F 2 "MountingHole:MountingHole_5mm_Pad" H 10425 4575 50  0001 C CNN
F 3 "~" H 10425 4575 50  0001 C CNN
	1    10425 4575
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0131
U 1 1 619BB583
P 10575 4650
F 0 "#PWR0131" H 10575 4400 50  0001 C CNN
F 1 "GND" H 10580 4477 50  0000 C CNN
F 2 "" H 10575 4650 50  0001 C CNN
F 3 "" H 10575 4650 50  0001 C CNN
	1    10575 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	10525 4575 10575 4575
Wire Wire Line
	10575 4575 10575 4650
Wire Wire Line
	10525 4400 10575 4400
Wire Wire Line
	10575 4400 10575 4575
Connection ~ 10575 4575
Wire Wire Line
	10525 4225 10575 4225
Wire Wire Line
	10575 4225 10575 4400
Connection ~ 10575 4400
Wire Wire Line
	10525 4050 10575 4050
Wire Wire Line
	10575 4050 10575 4225
Connection ~ 10575 4225
NoConn ~ 1550 5850
NoConn ~ 1550 5950
NoConn ~ 1550 5150
$Comp
L Device:Q_NMOS_GSD Q2
U 1 1 61A68A78
P 4850 6450
F 0 "Q2" H 5054 6496 50  0000 L CNN
F 1 "Q_NMOS_GSD" H 5054 6405 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 5050 6550 50  0001 C CNN
F 3 "~" H 4850 6450 50  0001 C CNN
	1    4850 6450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 61A7C612
P 4950 6650
F 0 "#PWR01" H 4950 6400 50  0001 C CNN
F 1 "GND" H 4955 6477 50  0000 C CNN
F 2 "" H 4950 6650 50  0001 C CNN
F 3 "" H 4950 6650 50  0001 C CNN
	1    4950 6650
	1    0    0    -1  
$EndComp
Wire Notes Line style solid
	9675 2975 9675 6535
Wire Wire Line
	2750 3500 3100 3500
Text Label 2750 3500 0    50   ~ 0
VDDCORE
$EndSCHEMATC
