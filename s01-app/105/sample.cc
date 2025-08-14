#include <iostream>
#include "util.h"

int main(int argc, char *argv[]) {
    std::cout << "CMAKE -- Hello world" << std::endl;
    std::cout << " - App is built using " << BUILD_TYPE << std::endl;

    // Call function from util file
    std::cout << call_helper() << std::endl;

    (void)argc;
    (void)argv;

    return 0;
}
