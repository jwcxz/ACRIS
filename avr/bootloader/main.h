/* A C R I S   P R O J E C T        *
 * LED Controller Bootloader        *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo - http://jwcxz.com/  *
 *                                  *
 * Main bootloader header file      *
 ************************************/

#include "config.h"
#include "macros.h"

#include <inttypes.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include <avr/boot.h>
#include <avr/eeprom.h>
