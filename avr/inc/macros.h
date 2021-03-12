#ifndef __MACROS_H
#define __MACROS_H


#define _ON(port,pin)  (port |= _BV(pin))
#define _OFF(port,pin) (port &= ~_BV(pin))
#define _BVON(port,pins)  (port |= pins)
#define _BVOFF(port,pins) (port &= pins)
#define _VAL(byte,pos) ((byte>>pos)&1)


#endif
