
#include "gtest/gtest.h"
#include "sample_lib.h"

TEST(AdditionTest, HandlesPositiveValues) {
  EXPECT_EQ(do_action(0, 1), 1);
  EXPECT_EQ(do_action(2, 1), 3);
}

TEST(AdditionTest, HandlesNegativeValues) {
  EXPECT_EQ(do_action(2, -2), 0);
  EXPECT_EQ(do_action(-2, -2), -4);
}
