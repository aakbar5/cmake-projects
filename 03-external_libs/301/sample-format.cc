#include <iostream>
#include <boost/format.hpp>

int main(int argc, char *argv[]) {
    std::cout << "CMAKE Boost -- Hello world" << std::endl;
    std::cout << " - App is built using " << BUILD_TYPE << std::endl;

    std::cout << "Boost.Format: " << boost::format("%1% %2% %3%\n") % "10" % "20" % "30";

    (void)argc;
    (void)argv;

    return 0;
}
