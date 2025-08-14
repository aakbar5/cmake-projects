#include <memory>
#define BOOST_TEST_MODULE Sample
#include <boost/test/unit_test.hpp>

BOOST_AUTO_TEST_SUITE(sample_tests)

BOOST_AUTO_TEST_CASE(test_case_1)
{
    BOOST_TEST_MESSAGE("");
    BOOST_TEST_MESSAGE("Test - Simple test");

    int *ptr = new int;
    BOOST_CHECK(ptr);

    int c = 4;
    BOOST_CHECK_EQUAL(c, 4);

    delete ptr;
}

BOOST_AUTO_TEST_SUITE_END()
