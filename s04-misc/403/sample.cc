#include <iostream>
#include "zlib.h"

int main() {
    const unsigned long srcLength = 20;
    unsigned char srcString[srcLength] = "Testing Testing";

    const unsigned long dstLength = 40;
    unsigned char dstString[srcLength];

    unsigned long compressedLength = dstLength;

    int ret = compress2(dstString, &compressedLength, srcString, srcLength, 9);
    if (ret == Z_OK) {
        std::cout << "String is compressed " << "\n"
                  << "  Raw length is " << srcLength << "\n"
                  << "  Compressed length is " << compressedLength << "\n";
    }
    else {
        std::cout << "Unable to compress string" << "\n";
    }

    return 0;
}
