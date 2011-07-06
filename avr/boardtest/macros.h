/* A C R I S   P R O J E C T ********
 * LED Controller                   *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo -- http://jwcxz.com/ *
 *                                  *
 * useful macros                    *
 ************************************/

#define _ON(port,pin)  (port |= _BV(pin))
#define _OFF(port,pin) (port &= ~_BV(pin))
#define _BVON(port,pins)  (port |= pins)
#define _BVOFF(port,pins) (port &= pins)
#define _VAL(byte,pos) ((byte>>pos)&1)
