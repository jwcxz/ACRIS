EESchema Schematic File Version 2  date Wed 14 Nov 2012 04:07:55 PM EST
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:atmel2
LIBS:monomeArduino
LIBS:sn75176b
LIBS:SparkFun
LIBS:tlc5940-tssop
LIBS:ledctrlr-cache
EELAYER 25  0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "5-RGB LED Controller Board"
Date "7 nov 2012"
Rev "2.0"
Comp "J. Colosimo"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L GND #PWR01
U 1 1 4ECD280C
P 4000 5800
F 0 "#PWR01" H 4000 5800 30  0001 C CNN
F 1 "GND" H 4000 5730 30  0001 C CNN
	1    4000 5800
	1    0    0    -1  
$EndComp
$Comp
L R R11
U 1 1 4ECD27FD
P 3750 5700
F 0 "R11" V 3830 5700 50  0000 C CNN
F 1 "10K" V 3750 5700 50  0000 C CNN
F 2 "SM0805" V 3850 5700 50  0001 C CNN
F 4 "RMCF0805JT10K0" V 3750 5700 60  0001 C CNN "Part"
F 5 "RMCF0805JT10K0CT-ND" V 3750 5700 60  0001 C CNN "DigikeyPart"
	1    3750 5700
	0    -1   -1   0   
$EndComp
$Comp
L CONN_1 PCRNR4
U 1 1 4DDEAE72
P 5950 7800
F 0 "PCRNR4" H 6000 7800 40  0000 L CNN
F 1 "CONN_1" H 5950 7855 30  0001 C CNN
F 2 "screw" H 6040 7760 60  0001 C CNN
F 4 "N/A" H 5950 7800 60  0001 C CNN "Part"
F 5 "N/A" H 5950 7800 60  0001 C CNN "DigikeyPart"
	1    5950 7800
	1    0    0    -1  
$EndComp
$Comp
L CONN_1 PCRNR3
U 1 1 4DDEAE70
P 5950 7700
F 0 "PCRNR3" H 6000 7700 40  0000 L CNN
F 1 "CONN_1" H 5950 7755 30  0001 C CNN
F 2 "screw" H 6040 7660 60  0001 C CNN
F 4 "N/A" H 5950 7700 60  0001 C CNN "Part"
F 5 "N/A" H 5950 7700 60  0001 C CNN "DigikeyPart"
	1    5950 7700
	1    0    0    -1  
$EndComp
$Comp
L CONN_1 PCRNR2
U 1 1 4DDEAE6E
P 5950 7600
F 0 "PCRNR2" H 6000 7600 40  0000 L CNN
F 1 "CONN_1" H 5950 7655 30  0001 C CNN
F 2 "screw" H 6040 7560 60  0001 C CNN
F 4 "N/A" H 5950 7600 60  0001 C CNN "Part"
F 5 "N/A" H 5950 7600 60  0001 C CNN "DigikeyPart"
	1    5950 7600
	1    0    0    -1  
$EndComp
$Comp
L CONN_1 PCRNR1
U 1 1 4DDEAE64
P 5950 7500
F 0 "PCRNR1" H 6000 7500 40  0000 L CNN
F 1 "CONN_1" H 5950 7555 30  0001 C CNN
F 2 "screw" H 6040 7460 60  0001 C CNN
F 4 "N/A" H 5950 7500 60  0001 C CNN "Part"
F 5 "N/A" H 5950 7500 60  0001 C CNN "DigikeyPart"
	1    5950 7500
	1    0    0    -1  
$EndComp
$Comp
L JUMPER JP1
U 1 1 4DDD4F59
P 2350 1150
F 0 "JP1" H 2350 1300 60  0000 C CNN
F 1 "JUMPER" H 2350 1070 40  0000 C CNN
F 2 "SM1206" H 2290 1360 60  0001 C CNN
F 4 "N/A" H 2350 1150 60  0001 C CNN "Part"
F 5 "N/A" H 2350 1150 60  0001 C CNN "DigikeyPart"
	1    2350 1150
	0    1    1    0   
$EndComp
$Comp
L R R10
U 1 1 4DDC2CAC
P 2250 6550
F 0 "R10" V 2150 6550 50  0000 C CNN
F 1 "120" V 2250 6550 50  0000 C CNN
F 2 "SM0805" V 2380 6500 60  0001 C CNN
F 4 "RMCF0805JT120R" H 2250 6550 60  0001 C CNN "Part"
F 5 "RMCF0805JT120RCT-ND" H 2250 6550 60  0001 C CNN "DigikeyPart"
	1    2250 6550
	-1   0    0    1   
$EndComp
$Comp
L CONN_1 PX1
U 1 1 4DDC28A6
P 4700 4500
F 0 "PX1" H 4750 4500 40  0000 L CNN
F 1 "CONN_1" H 4700 4555 30  0001 C CNN
F 2 "PAD" H 4790 4460 60  0001 C CNN
F 4 "N/A" H 4700 4500 60  0001 C CNN "Part"
F 5 "N/A" H 4700 4500 60  0001 C CNN "DigikeyPart"
	1    4700 4500
	1    0    0    -1  
$EndComp
$Comp
L CONN_1 PX3
U 1 1 4DDC2871
P 4700 2900
F 0 "PX3" H 4750 2900 40  0000 L CNN
F 1 "CONN_1" H 4700 2955 30  0001 C CNN
F 2 "PAD" H 4790 2860 60  0001 C CNN
F 4 "N/A" H 4700 2900 60  0001 C CNN "Part"
F 5 "N/A" H 4700 2900 60  0001 C CNN "DigikeyPart"
	1    4700 2900
	1    0    0    -1  
$EndComp
$Comp
L CONN_1 PX5
U 1 1 4DDC285E
P 4700 3850
F 0 "PX5" H 4750 3850 40  0000 L CNN
F 1 "CONN_1" H 4700 3905 30  0001 C CNN
F 2 "PAD" H 4790 3810 60  0001 C CNN
F 4 "N/A" H 4700 3850 60  0001 C CNN "Part"
F 5 "N/A" H 4700 3850 60  0001 C CNN "DigikeyPart"
	1    4700 3850
	1    0    0    -1  
$EndComp
$Comp
L CONN_1 PX4
U 1 1 4DDC2840
P 4700 3750
F 0 "PX4" H 4750 3750 40  0000 L CNN
F 1 "CONN_1" H 4700 3805 30  0001 C CNN
F 2 "PAD" H 4790 3710 60  0001 C CNN
F 4 "N/A" H 4700 3750 60  0001 C CNN "Part"
F 5 "N/A" H 4700 3750 60  0001 C CNN "DigikeyPart"
	1    4700 3750
	1    0    0    -1  
$EndComp
$Comp
L CP1 C3
U 1 1 4DDC21B3
P 1850 1650
F 0 "C3" H 1900 1750 50  0000 L CNN
F 1 "100uF" H 1750 1550 50  0000 L CNN
F 2 "Elko_vert_DM7-5_RM2-5" H 1850 1650 60  0001 C CNN
F 4 "ESK107M025AE3AA" H 1850 1650 60  0001 C CNN "Part"
F 5 "399-6103-ND" H 1850 1650 60  0001 C CNN "DigikeyPart"
	1    1850 1650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 4DDC1BE1
P 5900 3950
F 0 "#PWR02" H 5900 3950 30  0001 C CNN
F 1 "GND" H 5900 3880 30  0001 C CNN
	1    5900 3950
	1    0    0    -1  
$EndComp
$Comp
L R R9
U 1 1 4DDC0C79
P 5650 3900
F 0 "R9" V 5730 3900 50  0000 C CNN
F 1 "1K" V 5650 3900 50  0000 C CNN
F 2 "SM0805" V 5780 3850 60  0001 C CNN
F 4 "RMCF0805JT1K00" H 5650 3900 60  0001 C CNN "Part"
F 5 "RMCF0805JT1K00CT-ND" H 5650 3900 60  0001 C CNN "DigikeyPart"
	1    5650 3900
	0    -1   -1   0   
$EndComp
$Comp
L LED D5
U 1 1 4DDC0C78
P 5150 3900
F 0 "D5" H 5050 3850 50  0000 C CNN
F 1 "LED" H 5150 3800 50  0000 C CNN
F 2 "LED-1206-3D" H 5000 3800 60  0001 C CNN
F 4 "APT3216SGC" H 5150 3900 60  0001 C CNN "Part"
F 5 "754-1141-1-ND" H 5150 3900 60  0001 C CNN "DigikeyPart"
	1    5150 3900
	1    0    0    -1  
$EndComp
$Comp
L LED D4
U 1 1 4DDC0C6F
P 5150 3700
F 0 "D4" H 5050 3650 50  0000 C CNN
F 1 "LED" H 5150 3600 50  0000 C CNN
F 2 "LED-1206-3D" H 5000 3600 60  0001 C CNN
F 4 "APT3216SGC" H 5150 3700 60  0001 C CNN "Part"
F 5 "754-1141-1-ND" H 5150 3700 60  0001 C CNN "DigikeyPart"
	1    5150 3700
	1    0    0    -1  
$EndComp
$Comp
L R R8
U 1 1 4DDC0C6E
P 5650 3700
F 0 "R8" V 5730 3700 50  0000 C CNN
F 1 "1K" V 5650 3700 50  0000 C CNN
F 2 "SM0805" V 5780 3650 60  0001 C CNN
F 4 "RMCF0805JT1K00" H 5650 3700 60  0001 C CNN "Part"
F 5 "RMCF0805JT1K00CT-ND" H 5650 3700 60  0001 C CNN "DigikeyPart"
	1    5650 3700
	0    -1   -1   0   
$EndComp
$Comp
L R R7
U 1 1 4DDC0C45
P 5650 3500
F 0 "R7" V 5730 3500 50  0000 C CNN
F 1 "1K" V 5650 3500 50  0000 C CNN
F 2 "SM0805" V 5780 3450 60  0001 C CNN
F 4 "RMCF0805JT1K00" H 5650 3500 60  0001 C CNN "Part"
F 5 "RMCF0805JT1K00CT-ND" H 5650 3500 60  0001 C CNN "DigikeyPart"
	1    5650 3500
	0    -1   -1   0   
$EndComp
$Comp
L LED D3
U 1 1 4DDC0C44
P 5150 3500
F 0 "D3" H 5050 3450 50  0000 C CNN
F 1 "LED" H 5150 3400 50  0000 C CNN
F 2 "LED-1206-3D" H 5000 3400 60  0001 C CNN
F 4 "APT3216SGC" H 5150 3500 60  0001 C CNN "Part"
F 5 "754-1141-1-ND" H 5150 3500 60  0001 C CNN "DigikeyPart"
	1    5150 3500
	1    0    0    -1  
$EndComp
$Comp
L LED D2
U 1 1 4DDC0B98
P 5150 3300
F 0 "D2" H 5050 3250 50  0000 C CNN
F 1 "LED" H 5150 3200 50  0000 C CNN
F 2 "LED-1206-3D" H 5000 3200 60  0001 C CNN
F 4 "APT3216SGC" H 5150 3300 60  0001 C CNN "Part"
F 5 "754-1141-1-ND" H 5150 3300 60  0001 C CNN "DigikeyPart"
	1    5150 3300
	1    0    0    -1  
$EndComp
$Comp
L R R6
U 1 1 4DDC0B97
P 5650 3300
F 0 "R6" V 5730 3300 50  0000 C CNN
F 1 "1K" V 5650 3300 50  0000 C CNN
F 2 "SM0805" V 5780 3250 60  0001 C CNN
F 4 "RMCF0805JT1K00" H 5650 3300 60  0001 C CNN "Part"
F 5 "RMCF0805JT1K00CT-ND" H 5650 3300 60  0001 C CNN "DigikeyPart"
	1    5650 3300
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR03
U 1 1 4DDC074E
P 7000 7050
F 0 "#PWR03" H 7000 7050 30  0001 C CNN
F 1 "GND" H 7000 6980 30  0001 C CNN
	1    7000 7050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 4DDC05F8
P 7000 2800
F 0 "#PWR04" H 7000 2800 30  0001 C CNN
F 1 "GND" H 7000 2730 30  0001 C CNN
	1    7000 2800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 4DDC0557
P 7000 4900
F 0 "#PWR05" H 7000 4900 30  0001 C CNN
F 1 "GND" H 7000 4830 30  0001 C CNN
	1    7000 4900
	1    0    0    -1  
$EndComp
$Comp
L C C6
U 1 1 4D1A474A
P 3650 1800
F 0 "C6" H 3700 1700 50  0000 L CNN
F 1 "8pF" H 3700 1900 50  0000 L CNN
F 2 "SM0805" H 3650 1800 60  0001 C CNN
F 4 "CC0805DRNPO9BN8R0" H 3650 1800 60  0001 C CNN "Part"
F 5 "311-1097-1-ND" H 3650 1800 60  0001 C CNN "DigikeyPart"
	1    3650 1800
	-1   0    0    1   
$EndComp
$Comp
L ATMEGA168-P IC1
U 1 1 4D33D4BE
P 3600 3650
F 0 "IC1" H 2800 4950 50  0000 L BNN
F 1 "ATMEGA168-P" H 3750 2300 50  0000 L BNN
F 2 "DIP-28__300" H 2900 2350 50  0001 C CNN
F 4 "ATMEGA168-20PU" H 3600 3650 60  0001 C CNN "Part"
F 5 "ATMEGA168-20PU-ND" H 3600 3650 60  0001 C CNN "DigikeyPart"
	1    3600 3650
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 4DDC0401
P 4250 1000
F 0 "R1" V 4330 1000 50  0000 C CNN
F 1 "1K" V 4250 1000 50  0000 C CNN
F 2 "SM0805" V 4380 950 60  0001 C CNN
F 4 "RMCF0805JT1K00" H 4250 1000 60  0001 C CNN "Part"
F 5 "RMCF0805JT1K00CT-ND" H 4250 1000 60  0001 C CNN "DigikeyPart"
	1    4250 1000
	1    0    0    -1  
$EndComp
$Comp
L LED D1
U 1 1 4DDC03FC
P 3950 750
F 0 "D1" H 3950 850 50  0000 C CNN
F 1 "LED" H 3950 650 50  0000 C CNN
F 2 "LED-1206-3D" H 3950 750 60  0001 C CNN
F 4 "APT3216SRCPRV" H 3950 750 60  0001 C CNN "Part"
F 5 "754-1142-1-ND" H 3950 750 60  0001 C CNN "DigikeyPart"
	1    3950 750 
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 4DDBFE8A
P 2000 1050
F 0 "C1" H 2050 1150 50  0000 L CNN
F 1 ".33uF" H 1900 950 50  0000 L CNN
F 2 "SM0805" H 2000 1050 60  0001 C CNN
F 4 "C2012X7R1C334K/1.25" H 2000 1050 60  0001 C CNN "Part"
F 5 "445-1356-1-ND" H 2000 1050 60  0001 C CNN "DigikeyPart"
	1    2000 1050
	1    0    0    -1  
$EndComp
$Comp
L LM7805 U1
U 1 1 4DDBFCAC
P 2750 900
F 0 "U1" H 2900 704 60  0000 C CNN
F 1 "LM7805" H 2750 1100 60  0000 C CNN
F 2 "LM78XXV-3D" H 2960 644 60  0001 C CNN
F 4 "LM7805CT" H 2750 900 60  0001 C CNN "Part"
F 5 "LM7805CT-ND" H 2750 900 60  0001 C CNN "DigikeyPart"
	1    2750 900 
	1    0    0    -1  
$EndComp
$Comp
L JACK_2P JLEDPWR2
U 1 1 4DDBFCA6
P 1200 1550
F 0 "JLEDPWR2" H 1000 1350 60  0000 C CNN
F 1 "JACK_2P" H 1050 1800 60  0000 C CNN
F 2 "JACK_ALIM" H 940 1290 60  0001 C CNN
F 4 "PJ-202A" H 1200 1550 60  0001 C CNN "Part"
F 5 "CP-202A-ND" H 1200 1550 60  0001 C CNN "DigikeyPart"
	1    1200 1550
	1    0    0    1   
$EndComp
$Comp
L CONN_1 PGND1
U 1 1 4D34992F
P 2750 1700
F 0 "PGND1" V 2750 1450 40  0000 L CNN
F 1 "CONN_1" H 2750 1755 30  0001 C CNN
F 2 "PAD" V 2610 1890 60  0001 C CNN
F 4 "N/A" H 2750 1700 60  0001 C CNN "Part"
F 5 "N/A" H 2750 1700 60  0001 C CNN "DigikeyPart"
	1    2750 1700
	0    1    -1   0   
$EndComp
$Comp
L GNDPWR #PWR06
U 1 1 4D348E30
P 2550 1950
F 0 "#PWR06" H 2550 2000 40  0001 C CNN
F 1 "GNDPWR" H 2550 1850 40  0000 C CNN
	1    2550 1950
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR07
U 1 1 4D346430
P 8550 5150
F 0 "#PWR07" H 8550 5200 40  0001 C CNN
F 1 "GNDPWR" H 8550 5070 40  0000 C CNN
	1    8550 5150
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR08
U 1 1 4D34641E
P 6900 5800
F 0 "#PWR08" H 6900 5850 40  0001 C CNN
F 1 "GNDPWR" H 6900 5720 40  0000 C CNN
	1    6900 5800
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR09
U 1 1 4D346407
P 8550 3000
F 0 "#PWR09" H 8550 3050 40  0001 C CNN
F 1 "GNDPWR" H 8550 2920 40  0000 C CNN
	1    8550 3000
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR010
U 1 1 4D3463F5
P 6900 3650
F 0 "#PWR010" H 6900 3700 40  0001 C CNN
F 1 "GNDPWR" H 6900 3570 40  0000 C CNN
	1    6900 3650
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR011
U 1 1 4D346394
P 8550 850
F 0 "#PWR011" H 8550 900 40  0001 C CNN
F 1 "GNDPWR" H 8550 770 40  0000 C CNN
	1    8550 850 
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR012
U 1 1 4D346371
P 6900 1500
F 0 "#PWR012" H 6900 1550 40  0001 C CNN
F 1 "GNDPWR" H 6900 1420 40  0000 C CNN
	1    6900 1500
	1    0    0    -1  
$EndComp
$Comp
L JACK_2P JLGCPWR1
U 1 1 4D33F3A4
P 1200 950
F 0 "JLGCPWR1" H 1000 750 60  0000 C CNN
F 1 "JACK_2P" H 1050 1200 60  0000 C CNN
F 2 "JACK_ALIM" H 940 690 60  0001 C CNN
F 4 "PJ-202A" H 1200 950 60  0001 C CNN "Part"
F 5 "CP-202A-ND" H 1200 950 60  0001 C CNN "DigikeyPart"
	1    1200 950 
	1    0    0    1   
$EndComp
$Comp
L CONN_1 PSOUT1
U 1 1 4D33E6B1
P 7350 6850
F 0 "PSOUT1" H 7430 6850 40  0000 L CNN
F 1 "CONN_1" H 7350 6905 30  0001 C CNN
F 2 "PAD" H 7470 6810 60  0001 C CNN
F 4 "N/A" H 7350 6850 60  0001 C CNN "Part"
F 5 "N/A" H 7350 6850 60  0001 C CNN "DigikeyPart"
	1    7350 6850
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR013
U 1 1 4D33DF5E
P 3500 750
F 0 "#PWR013" H 3500 850 30  0001 C CNN
F 1 "VCC" H 3500 850 30  0000 C CNN
	1    3500 750 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR014
U 1 1 4D33DF5B
P 2750 1300
F 0 "#PWR014" H 2750 1300 30  0001 C CNN
F 1 "GND" H 2750 1230 30  0001 C CNN
	1    2750 1300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR015
U 1 1 4D33DE07
P 7000 5150
F 0 "#PWR015" H 7000 5150 30  0001 C CNN
F 1 "GND" H 7000 5080 30  0001 C CNN
	1    7000 5150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR016
U 1 1 4D33DDEF
P 7000 3000
F 0 "#PWR016" H 7000 3000 30  0001 C CNN
F 1 "GND" H 7000 2930 30  0001 C CNN
	1    7000 3000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR017
U 1 1 4D33DDCE
P 7000 850
F 0 "#PWR017" H 7000 850 30  0001 C CNN
F 1 "GND" H 7000 780 30  0001 C CNN
	1    7000 850 
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR018
U 1 1 4D260EB4
P 2250 5400
F 0 "#PWR018" H 2250 5500 30  0001 C CNN
F 1 "VCC" H 2250 5500 30  0000 C CNN
	1    2250 5400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR019
U 1 1 4D1A54BC
P 3950 1700
F 0 "#PWR019" H 3950 1700 30  0001 C CNN
F 1 "GND" H 3950 1630 30  0001 C CNN
	1    3950 1700
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH SW1
U 1 1 4D1A5263
P 5550 4850
F 0 "SW1" H 5700 4960 50  0000 C CNN
F 1 "SW_PUSH" H 5550 4770 50  0000 C CNN
F 2 "PUSH_SW" H 5550 4850 60  0001 C CNN
F 4 "FSMRA2JH" H 5550 4850 60  0001 C CNN "Part"
F 5 "450-1662-ND" H 5550 4850 60  0001 C CNN "DigikeyPart"
	1    5550 4850
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 4D1A5248
P 5600 4650
F 0 "R2" V 5500 4650 50  0000 C CNN
F 1 "10K" V 5600 4650 50  0000 C CNN
F 2 "SM0805" V 5730 4600 60  0001 C CNN
F 4 "RMCF0805JT10K0" H 5600 4650 60  0001 C CNN "Part"
F 5 "RMCF0805JT10K0CT-ND" H 5600 4650 60  0001 C CNN "DigikeyPart"
	1    5600 4650
	0    1    1    0   
$EndComp
$Comp
L GND #PWR020
U 1 1 4D1A5244
P 5850 5200
F 0 "#PWR020" H 5850 5200 30  0001 C CNN
F 1 "GND" H 5850 5130 30  0001 C CNN
	1    5850 5200
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR021
U 1 1 4D1A5240
P 5850 4600
F 0 "#PWR021" H 5850 4700 30  0001 C CNN
F 1 "VCC" H 5850 4700 30  0000 C CNN
	1    5850 4600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR022
U 1 1 4D1A4A17
P 2600 4900
F 0 "#PWR022" H 2600 4900 30  0001 C CNN
F 1 "GND" H 2600 4830 30  0001 C CNN
	1    2600 4900
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR023
U 1 1 4D1A49FA
P 2600 2400
F 0 "#PWR023" H 2600 2500 30  0001 C CNN
F 1 "VCC" H 2600 2500 30  0000 C CNN
	1    2600 2400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR024
U 1 1 4D1A47F9
P 2250 6200
F 0 "#PWR024" H 2250 6200 30  0001 C CNN
F 1 "GND" H 2250 6130 30  0001 C CNN
	1    2250 6200
	1    0    0    -1  
$EndComp
$Comp
L CRYSTAL X1
U 1 1 4D1A4743
P 3950 2100
F 0 "X1" H 3950 2250 60  0000 C CNN
F 1 "CRYSTAL" H 3950 1950 60  0000 C CNN
F 2 "Crystal_FOX-FE_SMD_RevA_09Aug2010" H 3890 2310 60  0001 C CNN
F 4 "NX8045GB-20.000000MHZ" H 3950 2100 60  0001 C CNN "Part"
F 5 "644-1026-1-ND" H 3950 2100 60  0001 C CNN "DigikeyPart"
	1    3950 2100
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR025
U 1 1 4D1A46AC
P 7100 5900
F 0 "#PWR025" H 7100 6000 30  0001 C CNN
F 1 "VCC" H 7100 6000 30  0000 C CNN
	1    7100 5900
	1    0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 4D1A46AB
P 7000 6750
F 0 "R5" V 6900 6750 50  0000 C CNN
F 1 "325.5" V 7000 6750 50  0000 C CNN
F 2 "SM0805" V 6850 6700 60  0001 C CNN
F 4 "RMCF0805JT330R" H 7000 6750 60  0001 C CNN "Part"
F 5 "RMCF0805JT330RCT-ND" H 7000 6750 60  0001 C CNN "DigikeyPart"
	1    7000 6750
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 4D1A469E
P 7000 4600
F 0 "R4" V 6900 4600 50  0000 C CNN
F 1 "325.5" V 7000 4600 50  0000 C CNN
F 2 "SM0805" V 6850 4550 60  0001 C CNN
F 4 "RMCF0805JT330R" H 7000 4600 60  0001 C CNN "Part"
F 5 "RMCF0805JT330RCT-ND" H 7000 4600 60  0001 C CNN "DigikeyPart"
	1    7000 4600
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR026
U 1 1 4D1A469D
P 7100 3750
F 0 "#PWR026" H 7100 3850 30  0001 C CNN
F 1 "VCC" H 7100 3850 30  0000 C CNN
	1    7100 3750
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR027
U 1 1 4D1A459E
P 7100 1600
F 0 "#PWR027" H 7100 1700 30  0001 C CNN
F 1 "VCC" H 7100 1700 30  0000 C CNN
	1    7100 1600
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 4D1A455D
P 7000 2500
F 0 "R3" V 6900 2500 50  0000 C CNN
F 1 "325.5" V 7000 2500 50  0000 C CNN
F 2 "SM0805" V 6850 2450 60  0001 C CNN
F 4 "RMCF0805JT330R" H 7000 2500 60  0001 C CNN "Part"
F 5 "RMCF0805JT330RCT-ND" H 7000 2500 60  0001 C CNN "DigikeyPart"
	1    7000 2500
	1    0    0    -1  
$EndComp
$Comp
L RJ45 J1
U 1 1 4D1A4291
P 1250 6450
F 0 "J1" H 1450 6950 60  0000 C CNN
F 1 "RJ45" H 1100 6950 60  0000 C CNN
F 2 "RJ45_8" H 1510 7010 60  0001 C CNN
F 4 "95501-2882" H 1250 6450 60  0001 C CNN "Part"
F 5 "WM5572-ND" H 1250 6450 60  0001 C CNN "DigikeyPart"
	1    1250 6450
	0    -1   -1   0   
$EndComp
$Comp
L RJ45 J2
U 1 1 4D1A428F
P 1250 5450
F 0 "J2" H 1450 5950 60  0000 C CNN
F 1 "RJ45" H 1100 5950 60  0000 C CNN
F 2 "RJ45_8" H 1510 6010 60  0001 C CNN
F 4 "95501-2882" H 1250 5450 60  0001 C CNN "Part"
F 5 "WM5572-ND" H 1250 5450 60  0001 C CNN "DigikeyPart"
	1    1250 5450
	0    -1   -1   0   
$EndComp
$Comp
L SN75176B IC2
U 1 1 4D1A428B
P 2450 5900
F 0 "IC2" H 1740 6420 50  0000 L BNN
F 1 "SN75176B" H 1740 5510 50  0000 L BNN
F 2 "SOIC8" H 2100 6000 50  0001 C CNN
F 4 "SN75176BP" H 2450 5900 60  0001 C CNN "Part"
F 5 "296-1739-5-ND" H 2450 5900 60  0001 C CNN "DigikeyPart"
	1    2450 5900
	-1   0    0    -1  
$EndComp
$Comp
L VAA #PWR028
U 1 1 4F6A103D
P 2550 1450
F 0 "#PWR028" H 2550 1510 30  0001 C CNN
F 1 "VAA" H 2550 1560 30  0000 C CNN
	1    2550 1450
	1    0    0    -1  
$EndComp
$Comp
L CONN_4 LED0
U 1 1 4F6A108A
P 10250 2950
F 0 "LED0" V 10200 2950 50  0000 C CNN
F 1 "CONN_4" V 10300 2950 50  0000 C CNN
F 2 "OSTTA040161p" V 10400 2950 50  0001 C CNN
F 4 "OSTTA040161" H 10250 2950 60  0001 C CNN "Part"
F 5 "ED2563-ND" V 10250 2950 60  0001 C CNN "DigikeyPart"
	1    10250 2950
	1    0    0    -1  
$EndComp
$Comp
L CONN_4 LED1
U 1 1 4F6A1097
P 10250 3450
F 0 "LED1" V 10200 3450 50  0000 C CNN
F 1 "CONN_4" V 10300 3450 50  0000 C CNN
F 2 "OSTTA040161p" V 10400 3450 50  0001 C CNN
F 4 "OSTTA040161" H 10250 3450 60  0001 C CNN "Part"
F 5 "ED2563-ND" V 10250 3450 60  0001 C CNN "Digikey"
	1    10250 3450
	1    0    0    -1  
$EndComp
$Comp
L CONN_4 LED2
U 1 1 4F6A109D
P 10250 3950
F 0 "LED2" V 10200 3950 50  0000 C CNN
F 1 "CONN_4" V 10300 3950 50  0000 C CNN
F 2 "OSTTA040161p" V 10400 3950 50  0001 C CNN
F 4 "OSTTA040161" H 10250 3950 60  0001 C CNN "Part"
F 5 "ED2563-ND" V 10250 3950 60  0001 C CNN "DigikeyPart"
	1    10250 3950
	1    0    0    -1  
$EndComp
$Comp
L CONN_4 LED3
U 1 1 4F6A10A3
P 10250 4450
F 0 "LED3" V 10200 4450 50  0000 C CNN
F 1 "CONN_4" V 10300 4450 50  0000 C CNN
F 2 "OSTTA040161p" V 10400 4450 50  0001 C CNN
F 4 "OSTTA040161" H 10250 4450 60  0001 C CNN "Part"
F 5 "ED2563-ND" V 10250 4450 60  0001 C CNN "DigikeyPart"
	1    10250 4450
	1    0    0    -1  
$EndComp
$Comp
L CONN_4 LED4
U 1 1 4F6A10A9
P 10250 4950
F 0 "LED4" V 10200 4950 50  0000 C CNN
F 1 "CONN_4" V 10300 4950 50  0000 C CNN
F 2 "OSTTA040161p" V 10400 4950 50  0001 C CNN
F 4 "OSTTA040161" H 10250 4950 60  0001 C CNN "Part"
F 5 "ED2563-ND" V 10250 4950 60  0001 C CNN "DigikeyPart"
	1    10250 4950
	1    0    0    -1  
$EndComp
$Comp
L VAA #PWR029
U 1 1 4F6A10B1
P 9800 2650
F 0 "#PWR029" H 9800 2710 30  0001 C CNN
F 1 "VAA" H 9800 2760 30  0000 C CNN
	1    9800 2650
	1    0    0    -1  
$EndComp
Text GLabel 8550 1050 2    60   Output ~ 0
LEDRED0
Text GLabel 8550 1350 2    60   Output ~ 0
LEDGRN0
Text GLabel 8550 1650 2    60   Output ~ 0
LEDBLU0
Text GLabel 8550 1950 2    60   Output ~ 0
LEDRED1
Text GLabel 8550 2250 2    60   Output ~ 0
LEDGRN1
Text GLabel 8550 3200 2    60   Output ~ 0
LEDBLU1
Text GLabel 8550 3500 2    60   Output ~ 0
LEDRED2
Text GLabel 8550 3800 2    60   Output ~ 0
LEDGRN2
Text GLabel 8550 4100 2    60   Output ~ 0
LEDBLU2
Text GLabel 8550 4400 2    60   Output ~ 0
LEDRED3
Text GLabel 8550 5350 2    60   Output ~ 0
LEDGRN3
Text GLabel 8550 5650 2    60   Output ~ 0
LEDBLU3
Text GLabel 8550 5950 2    60   Output ~ 0
LEDRED4
Text GLabel 8550 6250 2    60   Output ~ 0
LEDGRN4
Text GLabel 8550 6550 2    60   Output ~ 0
LEDBLU4
Text GLabel 9700 2900 0    60   Input ~ 0
LEDRED0
Text GLabel 9700 3000 0    60   Input ~ 0
LEDGRN0
Text GLabel 9700 3100 0    60   Input ~ 0
LEDBLU0
Text GLabel 9700 3400 0    60   Input ~ 0
LEDRED1
Text GLabel 9700 3500 0    60   Input ~ 0
LEDGRN1
Text GLabel 9700 3600 0    60   Input ~ 0
LEDBLU1
Text GLabel 9700 3900 0    60   Input ~ 0
LEDRED2
Text GLabel 9700 4000 0    60   Input ~ 0
LEDGRN2
Text GLabel 9700 4100 0    60   Input ~ 0
LEDBLU2
Text GLabel 9700 4400 0    60   Input ~ 0
LEDRED3
Text GLabel 9700 4500 0    60   Input ~ 0
LEDGRN3
Text GLabel 9700 4600 0    60   Input ~ 0
LEDBLU3
Text GLabel 9700 4900 0    60   Input ~ 0
LEDRED4
Text GLabel 9700 5000 0    60   Input ~ 0
LEDGRN4
Text GLabel 9700 5100 0    60   Input ~ 0
LEDBLU4
NoConn ~ 900  4900
NoConn ~ 900  5900
NoConn ~ 5800 7500
NoConn ~ 5800 7600
NoConn ~ 5800 7700
NoConn ~ 5800 7800
$Comp
L C C4
U 1 1 4F6CC56C
P 3300 1050
F 0 "C4" H 3350 1150 50  0000 L CNN
F 1 ".1uF" H 3350 950 50  0000 L CNN
F 2 "SM0805" H 3300 1050 60  0001 C CNN
F 4 "CC0805ZRY5V9BB104" H 3300 1050 60  0001 C CNN "Part"
F 5 "311-1361-1-ND" H 3300 1050 60  0001 C CNN "DigikeyPart"
	1    3300 1050
	1    0    0    -1  
$EndComp
$Comp
L C C5
U 1 1 4F6CEF29
P 5550 5100
F 0 "C5" V 5500 5200 50  0000 L CNN
F 1 ".1uF" V 5500 4850 50  0000 L CNN
F 2 "SM0805" H 5550 5100 60  0001 C CNN
F 4 "CC0805ZRY5V9BB104" H 5550 5100 60  0001 C CNN "Part"
F 5 "311-1361-1-ND" H 5550 5100 60  0001 C CNN "DigikeyPart"
	1    5550 5100
	0    -1   -1   0   
$EndComp
$Comp
L C C2
U 1 1 4F6CF210
P 2150 1650
F 0 "C2" H 2200 1750 50  0000 L CNN
F 1 ".33uF" H 2050 1550 50  0000 L CNN
F 2 "SM0805" H 2150 1650 60  0001 C CNN
F 4 "C2012X7R1C334K/1.25" H 2150 1650 60  0001 C CNN "Part"
F 5 "445-1356-1-ND" H 2150 1650 60  0001 C CNN "DigikeyPart"
	1    2150 1650
	1    0    0    -1  
$EndComp
$Comp
L C C7
U 1 1 4F6CF7CE
P 4250 1800
F 0 "C7" H 4150 1700 50  0000 L CNN
F 1 "8pF" H 4100 1900 50  0000 L CNN
F 2 "SM0805" H 4250 1800 60  0001 C CNN
F 4 "CC0805DRNPO9BN8R0" H 4250 1800 60  0001 C CNN "Part"
F 5 "311-1097-1-ND" H 4250 1800 60  0001 C CNN "DigikeyPart"
	1    4250 1800
	-1   0    0    1   
$EndComp
$Comp
L CONN_1 PPWR1
U 1 1 4F6E48D8
P 2750 1600
F 0 "PPWR1" V 2750 1350 40  0000 L CNN
F 1 "CONN_1" H 2750 1655 30  0001 C CNN
F 2 "PAD" H 2750 1755 30  0001 C CNN
	1    2750 1600
	0    1    1    0   
$EndComp
$Comp
L CONN_1 PVCC1
U 1 1 4F6E4A82
P 3750 1000
F 0 "PVCC1" V 3750 750 40  0000 L CNN
F 1 "CONN_1" H 3750 1055 30  0001 C CNN
F 2 "PAD" H 3750 1155 30  0001 C CNN
	1    3750 1000
	0    1    1    0   
$EndComp
Text Label 5300 2800 0    60   ~ 0
SIN1
Text Label 5300 3000 0    60   ~ 0
SCLK
Text Label 5300 2600 0    60   ~ 0
XLAT
Text Label 5300 2700 0    60   ~ 0
BLANK
Text Label 5300 4400 0    60   ~ 0
GSCLK
Text Label 4600 4600 0    60   ~ 0
XERR1
Text Label 4600 5350 0    60   ~ 0
XERR2
Text Label 4600 6450 0    60   ~ 0
XERR3
Text Label 3500 5500 0    60   ~ 0
RXD
Text Label 3500 6100 0    60   ~ 0
TXD
Text Label 3500 5900 0    60   ~ 0
WEN
Text Label 1750 850  0    60   ~ 0
LGCVI
Text Label 7100 2750 0    60   ~ 0
SIN2
Text Label 7100 4850 0    60   ~ 0
SIN3
Text Label 7000 1850 2    60   ~ 0
IREF1
Text Label 7000 4000 2    60   ~ 0
IREF2
Text Label 7000 6150 2    60   ~ 0
IREF3
Text Label 1750 6700 0    60   ~ 0
DIFFA
Text Label 1750 6800 0    60   ~ 0
DIFFB
Text Label 2000 5650 0    60   ~ 0
RJ3
Text Label 1950 5550 0    60   ~ 0
RJ4
Text Label 1900 5450 0    60   ~ 0
RJ5
Text Label 1800 5250 0    60   ~ 0
RJ7
Text Label 1750 5150 0    60   ~ 0
RJ8
Text Label 1850 5350 0    60   ~ 0
RJ6
Text Label 4700 2350 0    60   ~ 0
XTAL1
Text Label 4700 2100 0    60   ~ 0
XTAL2
Text Label 4500 2900 0    60   ~ 0
XPB4
Text Label 4500 3750 0    60   ~ 0
XPC4
Text Label 4500 3850 0    60   ~ 0
XPC5
Text Label 4500 4500 0    60   ~ 0
XPD4
Text Label 5200 4200 0    60   ~ 0
RESET
Text Label 4600 3350 0    60   ~ 0
DBG0
Text Label 4600 3450 0    60   ~ 0
DBG1
Text Label 4600 3550 0    60   ~ 0
DBG2
Text Label 4600 3650 0    60   ~ 0
DBG3
Text Label 7100 6750 0    60   ~ 0
SOUT
$Comp
L TLC5940 TLC1
U 1 1 508C432B
P 7800 1550
F 0 "TLC1" H 7800 2300 60  0000 C CNN
F 1 "TLC5940" H 7850 1750 60  0000 C CNN
F 2 "DIP-28__300" H 7850 1850 60  0001 C CNN
F 4 "TLC5940NT" H 7800 1550 60  0001 C CNN "Part"
F 5 "296-17732-5-ND" H 7800 1550 60  0001 C CNN "DigikeyPart"
	1    7800 1550
	-1   0    0    -1  
$EndComp
$Comp
L TLC5940 TLC2
U 1 1 508C4347
P 7800 3700
F 0 "TLC2" H 7800 4450 60  0000 C CNN
F 1 "TLC5940" H 7850 3900 60  0000 C CNN
F 2 "DIP-28__300" H 7850 4000 60  0001 C CNN
F 4 "TLC5940NT" H 7800 3700 60  0001 C CNN "Part"
F 5 "296-17732-5-ND" H 7800 3700 60  0001 C CNN "DigikeyPart"
	1    7800 3700
	-1   0    0    -1  
$EndComp
$Comp
L TLC5940 TLC3
U 1 1 508C434D
P 7800 5850
F 0 "TLC3" H 7800 6600 60  0000 C CNN
F 1 "TLC5940" H 7850 6050 60  0000 C CNN
F 2 "DIP-28__300" H 7850 6150 60  0001 C CNN
F 4 "TLC5940NT" H 7800 5850 60  0001 C CNN "Part"
F 5 "296-17732-5-ND" H 7800 5850 60  0001 C CNN "DigikeyPart"
	1    7800 5850
	-1   0    0    -1  
$EndComp
$Comp
L VCC #PWR030
U 1 1 508C4765
P 5750 1800
F 0 "#PWR030" H 5750 1900 30  0001 C CNN
F 1 "VCC" H 5750 1900 30  0000 C CNN
	1    5750 1800
	1    0    0    -1  
$EndComp
$Comp
L R R12
U 1 1 508C4A05
P 5750 2150
F 0 "R12" V 5830 2150 50  0000 C CNN
F 1 "10K" V 5750 2150 50  0000 C CNN
F 2 "SM0805" V 5850 2150 50  0001 C CNN
F 4 "RMCF0805JT10K0" V 5750 2150 60  0001 C CNN "Part"
F 5 "RMCF0805JT10K0CT-ND" V 5750 2150 60  0001 C CNN "DigikeyPart"
	1    5750 2150
	-1   0    0    1   
$EndComp
$Comp
L CONN_1 PX2
U 1 1 50984858
P 4700 2500
F 0 "PX2" H 4750 2500 40  0000 L CNN
F 1 "CONN_1" H 4700 2555 30  0001 C CNN
F 2 "PAD" H 4790 2460 60  0001 C CNN
F 4 "N/A" H 4700 2500 60  0001 C CNN "Part"
F 5 "N/A" H 4700 2500 60  0001 C CNN "DigikeyPart"
	1    4700 2500
	1    0    0    -1  
$EndComp
Text Label 4500 2500 0    60   ~ 0
XPB0
Wire Wire Line
	1700 1550 1700 1850
Wire Wire Line
	1700 1550 1650 1550
Wire Wire Line
	1700 950  1700 1250
Wire Wire Line
	1700 950  1650 950 
Wire Wire Line
	4000 5700 4000 5800
Connection ~ 3450 5900
Wire Wire Line
	3450 5900 3450 5700
Wire Wire Line
	3750 750  3750 850 
Connection ~ 2050 6800
Wire Wire Line
	1700 6800 2250 6800
Wire Wire Line
	4500 4500 4550 4500
Wire Wire Line
	4500 2900 4550 2900
Wire Wire Line
	4500 3750 4550 3750
Wire Wire Line
	4500 4700 4550 4700
Wire Wire Line
	4550 4700 4550 5350
Wire Wire Line
	4550 5350 6100 5350
Wire Wire Line
	6100 5350 6100 4300
Wire Wire Line
	6100 4300 7200 4300
Wire Wire Line
	1700 1250 4250 1250
Connection ~ 5900 3700
Connection ~ 5200 4850
Wire Wire Line
	4950 3900 4900 3900
Wire Wire Line
	4900 3900 4900 3650
Wire Wire Line
	4900 3650 4500 3650
Wire Wire Line
	4950 3300 4950 3350
Wire Wire Line
	4950 3350 4500 3350
Wire Wire Line
	5350 3300 5400 3300
Wire Wire Line
	7200 1750 7000 1750
Wire Wire Line
	4250 2000 4250 2100
Wire Wire Line
	4500 3100 4950 3100
Wire Wire Line
	5200 4650 5350 4650
Wire Wire Line
	1700 5800 2250 5800
Wire Wire Line
	2250 5800 2250 5700
Wire Wire Line
	2550 1850 2550 1950
Connection ~ 2000 1250
Connection ~ 2350 850 
Connection ~ 6400 3300
Wire Wire Line
	7200 3300 6400 3300
Wire Wire Line
	7000 5150 7000 5100
Wire Wire Line
	7200 3000 7200 2950
Wire Wire Line
	7000 2800 7000 2750
Wire Wire Line
	8550 850  8550 800 
Wire Wire Line
	6900 3650 6900 3600
Wire Wire Line
	4500 2800 6150 2800
Wire Wire Line
	6150 2800 6150 950 
Wire Wire Line
	7200 6850 7100 6850
Wire Wire Line
	7100 6850 7100 6350
Wire Wire Line
	7100 6350 7200 6350
Wire Wire Line
	7200 2050 7100 2050
Wire Wire Line
	7100 2050 7100 3100
Wire Wire Line
	7100 3100 7200 3100
Wire Wire Line
	1900 5400 1900 6400
Wire Wire Line
	1700 5100 1750 5100
Wire Wire Line
	1750 5100 1750 6100
Wire Wire Line
	1750 6100 1700 6100
Wire Wire Line
	1700 5300 1850 5300
Wire Wire Line
	1850 5300 1850 6300
Wire Wire Line
	1850 6300 1700 6300
Wire Wire Line
	1900 5400 1700 5400
Wire Wire Line
	1900 6400 1700 6400
Wire Wire Line
	7200 5750 6900 5750
Wire Wire Line
	7200 1450 6900 1450
Connection ~ 6400 2600
Wire Wire Line
	6400 2600 4500 2600
Wire Wire Line
	6150 950  7200 950 
Wire Wire Line
	6250 3200 7200 3200
Wire Wire Line
	7200 1050 6250 1050
Connection ~ 6500 3400
Wire Wire Line
	6500 3400 7200 3400
Connection ~ 6650 4100
Wire Wire Line
	7200 6250 6650 6250
Wire Wire Line
	6650 6250 6650 1950
Wire Wire Line
	7100 1850 7100 1600
Wire Wire Line
	7100 1850 7200 1850
Wire Wire Line
	8550 800  8400 800 
Connection ~ 2600 2500
Wire Wire Line
	5850 4600 5850 4650
Wire Wire Line
	3350 5900 5000 5900
Wire Wire Line
	4500 4100 4950 4100
Wire Wire Line
	4950 4100 4950 5500
Wire Wire Line
	4950 5500 3350 5500
Wire Wire Line
	2250 5400 2250 5500
Connection ~ 2050 5800
Wire Wire Line
	2050 5800 2050 6800
Wire Wire Line
	7000 1750 7000 2250
Wire Wire Line
	7200 3750 7100 3750
Wire Wire Line
	7200 3750 7200 3700
Connection ~ 8400 4400
Wire Wire Line
	8400 4300 8400 4500
Connection ~ 8400 4100
Wire Wire Line
	8400 4000 8400 4200
Connection ~ 8400 3800
Wire Wire Line
	8400 3700 8400 3900
Connection ~ 8400 3500
Wire Wire Line
	8400 3400 8400 3600
Connection ~ 8400 3200
Wire Wire Line
	8400 3100 8400 3300
Wire Wire Line
	7200 3900 7000 3900
Wire Wire Line
	7000 3900 7000 4350
Wire Wire Line
	7200 2950 7000 2950
Wire Wire Line
	7000 5100 7200 5100
Wire Wire Line
	7000 7050 7000 7000
Wire Wire Line
	7000 6500 7000 6050
Wire Wire Line
	7000 6050 7200 6050
Wire Wire Line
	8400 5250 8400 5450
Connection ~ 8400 5350
Wire Wire Line
	8400 5550 8400 5750
Connection ~ 8400 5650
Wire Wire Line
	8400 5850 8400 6050
Connection ~ 8400 5950
Wire Wire Line
	8400 6150 8400 6350
Connection ~ 8400 6250
Wire Wire Line
	8400 6450 8400 6650
Connection ~ 8400 6550
Wire Wire Line
	7200 5850 7200 5900
Wire Wire Line
	7200 5900 7100 5900
Wire Wire Line
	2100 5900 2250 5900
Wire Wire Line
	1700 6700 2100 6700
Wire Wire Line
	2100 6700 2100 5700
Wire Wire Line
	2100 5700 1700 5700
Connection ~ 2100 5900
Wire Wire Line
	2250 6100 2250 6200
Wire Wire Line
	5050 4200 5050 6100
Wire Wire Line
	5050 4200 4500 4200
Wire Wire Line
	3950 1700 3950 1600
Wire Wire Line
	8400 3000 8400 2950
Wire Wire Line
	8400 2950 8550 2950
Wire Wire Line
	8550 2950 8550 3000
Wire Wire Line
	8400 5150 8400 5100
Wire Wire Line
	8400 5100 8550 5100
Wire Wire Line
	8550 5100 8550 5150
Wire Wire Line
	5050 6100 3350 6100
Wire Wire Line
	7200 4000 7100 4000
Wire Wire Line
	7100 4000 7100 3750
Wire Wire Line
	7200 6150 7100 6150
Wire Wire Line
	7100 6150 7100 5900
Wire Wire Line
	6650 1950 7200 1950
Wire Wire Line
	7200 4100 6650 4100
Wire Wire Line
	7200 1250 6500 1250
Wire Wire Line
	7200 5550 6500 5550
Wire Wire Line
	6500 5550 6500 1250
Wire Wire Line
	7200 5450 6400 5450
Wire Wire Line
	7200 1150 6400 1150
Wire Wire Line
	6250 1050 6250 5350
Wire Wire Line
	6250 5350 7200 5350
Connection ~ 6250 3200
Wire Wire Line
	4500 4300 5000 4300
Wire Wire Line
	4500 2700 6500 2700
Connection ~ 6500 2700
Connection ~ 4250 2100
Wire Wire Line
	6900 3600 7200 3600
Wire Wire Line
	1700 6500 1950 6500
Wire Wire Line
	1700 5500 1950 5500
Wire Wire Line
	1700 6600 2000 6600
Wire Wire Line
	2000 6600 2000 5600
Wire Wire Line
	2000 5600 1700 5600
Wire Wire Line
	1700 6200 1800 6200
Wire Wire Line
	1800 6200 1800 5200
Wire Wire Line
	1800 5200 1700 5200
Wire Wire Line
	1950 5500 1950 6500
Wire Wire Line
	7200 5250 7100 5250
Wire Wire Line
	7100 5250 7100 4200
Wire Wire Line
	7100 4200 7200 4200
Wire Wire Line
	2600 3100 2600 2400
Connection ~ 2600 2800
Connection ~ 6250 3000
Wire Wire Line
	4250 1600 3650 1600
Connection ~ 3950 1600
Wire Wire Line
	6900 1450 6900 1500
Wire Wire Line
	6900 5750 6900 5800
Wire Wire Line
	7000 2950 7000 3000
Wire Wire Line
	7200 5100 7200 5150
Wire Wire Line
	6250 3000 4500 3000
Wire Wire Line
	6400 1150 6400 5450
Wire Wire Line
	2600 4900 2600 4700
Connection ~ 2600 4800
Wire Wire Line
	2750 1300 2750 1150
Connection ~ 2000 850 
Connection ~ 2750 1250
Connection ~ 1850 1450
Connection ~ 2350 1450
Connection ~ 1850 1850
Connection ~ 3300 1250
Connection ~ 3300 850 
Wire Wire Line
	3500 850  3500 750 
Connection ~ 3500 850 
Wire Wire Line
	3750 850  3150 850 
Wire Wire Line
	5350 5100 5200 5100
Wire Wire Line
	4950 3100 4950 2350
Wire Wire Line
	4950 2350 3650 2350
Wire Wire Line
	3650 2350 3650 2000
Connection ~ 3650 2100
Wire Wire Line
	4500 3200 5000 3200
Wire Wire Line
	5000 3200 5000 2100
Wire Wire Line
	5000 2100 4250 2100
Wire Wire Line
	7000 4900 7000 4850
Wire Wire Line
	5350 3500 5400 3500
Wire Wire Line
	5350 3700 5400 3700
Wire Wire Line
	5350 3900 5400 3900
Wire Wire Line
	4500 3450 4950 3450
Wire Wire Line
	4950 3450 4950 3500
Wire Wire Line
	4500 3550 4950 3550
Wire Wire Line
	4950 3550 4950 3700
Wire Wire Line
	4500 3950 4550 3950
Wire Wire Line
	4550 3950 4550 4050
Wire Wire Line
	4550 4050 5200 4050
Wire Wire Line
	5200 4050 5200 5100
Connection ~ 5200 4650
Connection ~ 5900 3500
Wire Wire Line
	5900 3950 5900 3300
Connection ~ 5900 3900
Wire Wire Line
	4150 750  4250 750 
Wire Wire Line
	7200 6450 4500 6450
Wire Wire Line
	4500 6450 4500 4800
Wire Wire Line
	7200 2150 6000 2150
Wire Wire Line
	6000 2150 6000 4450
Wire Wire Line
	6000 4450 5100 4450
Wire Wire Line
	5100 4450 5100 4600
Wire Wire Line
	5100 4600 4500 4600
Wire Wire Line
	1700 1850 2900 1850
Connection ~ 2550 1850
Wire Wire Line
	4500 3850 4550 3850
Wire Wire Line
	2100 6300 2250 6300
Connection ~ 2100 6300
Wire Wire Line
	5000 4300 5000 5900
Wire Wire Line
	3500 5700 3350 5700
Connection ~ 3450 5700
Wire Wire Line
	2350 850  1650 850 
Wire Wire Line
	1650 1450 2750 1450
Wire Wire Line
	9800 2650 9800 4800
Wire Wire Line
	9800 2800 9900 2800
Wire Wire Line
	9800 3300 9900 3300
Connection ~ 9800 2800
Wire Wire Line
	9800 3800 9900 3800
Connection ~ 9800 3300
Wire Wire Line
	9800 4300 9900 4300
Connection ~ 9800 3800
Wire Wire Line
	9800 4800 9900 4800
Connection ~ 9800 4300
Wire Wire Line
	8550 1050 8400 1050
Wire Wire Line
	8550 1350 8400 1350
Wire Wire Line
	8550 1650 8400 1650
Wire Wire Line
	8550 1950 8400 1950
Wire Wire Line
	8550 2250 8400 2250
Wire Wire Line
	8400 3200 8550 3200
Wire Wire Line
	8400 3500 8550 3500
Wire Wire Line
	8400 3800 8550 3800
Wire Wire Line
	8400 4100 8550 4100
Wire Wire Line
	8400 4400 8550 4400
Wire Wire Line
	8400 5350 8550 5350
Wire Wire Line
	8400 5650 8550 5650
Wire Wire Line
	8400 5950 8550 5950
Wire Wire Line
	8400 6250 8550 6250
Wire Wire Line
	8400 6550 8550 6550
Wire Wire Line
	9700 2900 9900 2900
Wire Wire Line
	9700 3000 9900 3000
Wire Wire Line
	9700 3100 9900 3100
Wire Wire Line
	9700 3400 9900 3400
Wire Wire Line
	9700 3500 9900 3500
Wire Wire Line
	9700 3600 9900 3600
Wire Wire Line
	9700 3900 9900 3900
Wire Wire Line
	9700 4000 9900 4000
Wire Wire Line
	9700 4100 9900 4100
Wire Wire Line
	9700 4400 9900 4400
Wire Wire Line
	9700 4500 9900 4500
Wire Wire Line
	9700 4600 9900 4600
Wire Wire Line
	9700 4900 9900 4900
Wire Wire Line
	9700 5000 9900 5000
Wire Wire Line
	9700 5100 9900 5100
Wire Wire Line
	2900 1850 2900 1250
Connection ~ 2900 1250
Connection ~ 2150 1450
Connection ~ 2150 1850
Wire Wire Line
	1650 950  1650 1100
Wire Wire Line
	1650 1550 1650 1700
Wire Wire Line
	5850 4850 5850 5200
Wire Wire Line
	5750 5100 5850 5100
Connection ~ 5850 5100
Wire Wire Line
	5250 4850 5200 4850
Connection ~ 2750 1850
Connection ~ 2550 1450
Connection ~ 2550 1450
Connection ~ 3750 850 
Wire Wire Line
	7000 850  7000 800 
Wire Wire Line
	7000 800  7200 800 
Wire Wire Line
	7200 800  7200 850 
Wire Wire Line
	7100 1600 7200 1600
Wire Wire Line
	7200 1600 7200 1550
Wire Wire Line
	8400 800  8400 850 
Wire Wire Line
	8400 950  8400 1150
Connection ~ 8400 1050
Connection ~ 8400 1050
Wire Wire Line
	8400 1250 8400 1450
Connection ~ 8400 1350
Wire Wire Line
	8400 1550 8400 1750
Connection ~ 8400 1650
Wire Wire Line
	8400 1850 8400 2050
Connection ~ 8400 1950
Wire Wire Line
	8400 2150 8400 2350
Connection ~ 8400 2250
Wire Wire Line
	5750 2700 5750 2400
Connection ~ 5750 2700
Connection ~ 5750 2700
Wire Wire Line
	5750 1800 5750 1900
Wire Wire Line
	8000 5450 8000 5450
Wire Wire Line
	4500 4400 6650 4400
Connection ~ 6650 4400
Wire Wire Line
	4500 2500 4550 2500
$EndSCHEMATC
