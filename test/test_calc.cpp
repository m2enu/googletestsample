#include <gtest/gtest.h>
#include <gmock/gmock.h>

extern "C" {
#include "embcalc.h"
}

/** <!-- TestCalc {{{1 -->
 */
class TestCalc : public ::testing::Test {
    protected:
        virtual void SetUp(void) {
            ;
        }
        virtual void TearDown(void) {
            ;
        }
};

/** <!-- test_add {{{1 -->
 */
TEST_F(TestCalc, test_add) {
    EXPECT_EQ( 0, add( 0,  0));
    EXPECT_EQ( 1, add( 0,  1));
    EXPECT_EQ( 2, add( 1,  1));
    EXPECT_EQ(-1, add( 0, -1));
}

/** <!-- test_u16_s16 {{{1 -->
 */
TEST_F(TestCalc, test_u16_s16) {
    EXPECT_EQ(     0, u16_s16(0x0000));
    EXPECT_EQ(     1, u16_s16(0x0001));
    EXPECT_EQ( 32766, u16_s16(0x7ffe));
    EXPECT_EQ( 32767, u16_s16(0x7fff));
    EXPECT_EQ(-32768, u16_s16(0x8000));
    EXPECT_EQ(-32767, u16_s16(0x8001));
    EXPECT_EQ(    -2, u16_s16(0xfffe));
    EXPECT_EQ(    -1, u16_s16(0xffff));
}

/** <!-- test_s16_u16 {{{1 -->
 */
TEST_F(TestCalc, test_s16_u16) {
    EXPECT_EQ(0x0000, s16_u16(     0));
    EXPECT_EQ(0x0001, s16_u16(     1));
    EXPECT_EQ(0x7ffe, s16_u16( 32766));
    EXPECT_EQ(0x7fff, s16_u16( 32767));
    EXPECT_EQ(0x8000, s16_u16(-32768));
    EXPECT_EQ(0x8001, s16_u16(-32767));
    EXPECT_EQ(0xfffe, s16_u16(    -2));
    EXPECT_EQ(0xffff, s16_u16(    -1));
}

/** <!-- test_DISABLED_s16_u16 {{{1 -->
 */
TEST_F(TestCalc, DISABLED_test_s16_u16) {
    EXPECT_EQ(0x0000, s16_u16(     0));
}

// end of file {{{1
// vim:ft=cpp:et:nowrap:fdm=marker
