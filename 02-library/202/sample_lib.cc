
#include "sample_lib_config.h"
#include "sample_lib.h"

const char* sl_version(void) {
    return LIB_VERSION_STRING;
}

double sl_crea(double radius) {
    return 3.14159 * radius * radius;
}
