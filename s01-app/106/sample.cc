#include <iostream>
#include "util.h"
#include "sample_config.h"

int main(int argc, char *argv[]) {
    std::cout << "CMAKE -- Hello world" << std::endl;
    std::cout << " - App is built using " << BUILD_TYPE << std::endl;
    std::cout << " - App version: " << VERSION_MAJOR << "." << VERSION_MINOR << "." << VERSION_PATCH << std::endl;

    // Call function from util file
    std::cout << call_helper() << std::endl;

    (void)argc;
    (void)argv;

    return 0;
}
