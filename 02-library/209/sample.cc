#include <iostream>
#include "util.h"
#include "sample_config.h"
#include "sample_lib.h"

int main(int argc, char *argv[]) {
    std::cout << "CMAKE -- Hello world" << std::endl;
    std::cout << " - App is built using " << BUILD_TYPE << std::endl;
    std::cout << " - App version: " << VERSION_MAJOR << "." << VERSION_MINOR << "." << VERSION_PATCH << std::endl;

    // Call function from util file
    std::cout << call_helper() << std::endl;

    // Lambda expression to calculate area of the circle
    auto carea = [](auto radius) {
        return 3.14159 * radius * radius;
    };

    auto r = 1.2;
    std::cout << "Area of the circle: " << carea(r) << " where radius: "<< r << std::endl;

    r = 2.4;
    std::cout << "Area of the circle: " << carea(r) << " where radius: " << r << std::endl;

    // Get func from the library
    std::cout << "Area of the circle: " << sl_crea(r) << " where radius: " << r << " (library func)" << std::endl;

    (void)argc;
    (void)argv;

    return 0;
}
