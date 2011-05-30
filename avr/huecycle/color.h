#include "main.h"

typedef struct {uint8_t r, g, b;} rgb_t;
typedef struct {uint8_t h, s, v;} hsv_t;

void hsv2rgb(hsv_t, uint8_t*, uint8_t*, uint8_t*);
