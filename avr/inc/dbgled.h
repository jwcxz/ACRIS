#ifndef __DBGLED_H_
#define __DBGLED_H_

/* DEBUG LIGHTING */
#define DBG_PRTYERR     0x1
#define DBG_OVFLWERR    0x2

void dbg_set(uint8_t);
void dbg_on(uint8_t);
void dbg_off(uint8_t);
void dbg_init(void);

#endif
