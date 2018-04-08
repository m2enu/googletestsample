#include "embcalc.h"

/** <!-- add {{{1 -->
 */
int16_t add(int16_t x, int16_t y) {
    return x + y;
}

/** <!-- u16_s16 {{{1 -->
 */
int16_t u16_s16(uint16_t v) {
    if (v >= 0x8000) {
        int32_t ret = (int32_t)v - 0x10000;
        return (int16_t)ret;
    }
    return (int16_t)v;
}

/** <!-- s16_u16 {{{1 -->
 */
uint16_t s16_u16(int16_t v) {
    if (v < 0) {
        return (uint16_t)(v + 0x10000);
    }
    return (uint16_t)v;
}

// end of file {{{1
// vim:ft=c:et:nowrap:fdm=marker
