#include <iostream>

int main(int argc, char *argv[]) {
    std::cout << "CMAKE -- Hello world" << std::endl;
    std::cout << " - App is built using " << BUILD_TYPE << std::endl;

    (void)argc;
    (void)argv;

    return 0;
}
