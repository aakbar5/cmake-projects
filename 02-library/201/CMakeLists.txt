cmake_minimum_required(VERSION 3.1)
project(sample_static_lib)

# set file name
set(LIB_NAME sample_lib)

##
# Warning user on doing compilation inside the source
if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
    message(WARNING "*** Recommendation: Use separate build folder ***")
endif()

##-------------------- CMAKE_BUILD_TYPE -- START ------------------
# From commandline, one can set it via -DCMAKE_BUILD_TYPE=Release
# Set it if it is not set from commandline.

if(NOT CMAKE_BUILD_TYPE)
    # NOTE: `CACHE STRING "Choose the type of build" FORCE` is to make sure that
    # CMAKE_BUILD_TYPE has been set here.
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build" FORCE)

     # Set build types for cmake-gui otherwise cmake-gui will have empty line
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release")
endif()

##-------------------- Validate build type ------------------
# Error if build type is not properly setup
if(NOT CMAKE_BUILD_TYPE MATCHES "release|Release|RELEASE|debug|Debug|DEBUG")
    message("*** CMAKE_BUILD_TYPE is not set to known value:")
    message("*** Possible values: Release;Debug")
    message(FATAL_ERROR "*** CMAKE_BUILD_TYPE is not set properly")
endif()

##-------------------- Normalize build type ------------------
# Let's normalized user passed build type for ease of management
if((CMAKE_BUILD_TYPE MATCHES "DEBUG") OR (CMAKE_BUILD_TYPE MATCHES "debug"))
    set(CMAKE_BUILD_TYPE "Debug")
endif()

if((CMAKE_BUILD_TYPE MATCHES "RELEASE") OR (CMAKE_BUILD_TYPE MATCHES "release"))
    set(CMAKE_BUILD_TYPE "Release")
endif()

##-------------------- Customize build parameters ------------------
# Customize compiler flags as per build type
if(CMAKE_BUILD_TYPE MATCHES "Release")
    add_definitions(-DBUILD_TYPE="Release")
endif()

if(CMAKE_BUILD_TYPE MATCHES "Debug")
    add_definitions(-DBUILD_TYPE="Debug")
endif()

# Set default values of CXX flags for different builds.
# By default, cmake have following configuration
#   - CMAKE_CXX_FLAGS:
#   - CMAKE_CXX_FLAGS_DEBUG: -g
#   - CMAKE_CXX_FLAGS_RELEASE: -O3 -DNDEBUG
set(CMAKE_CXX_FLAGS "-pipe" CACHE STRING "Default CXX flags" FORCE)
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g -ggdb" CACHE STRING "Default CXX flags for Debug build" FORCE)
set(CMAKE_CXX_FLAGS_RELEASE "-O2 -DNDEBUG" CACHE STRING "Default CXX flags for Release build" FORCE)

##-------------------- CMAKE_BUILD_TYPE -- END ------------------

##------------------ CMake file generation -- START ---------------

# Set version
set(VERSION_MAJOR 1)
set(VERSION_MINOR 0)
set(VERSION_PATCH 0)

# Make version string
set(VERSION_STRING ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_MINOR})

# Configure a header file to have cmake version variables
configure_file(
    "${PROJECT_SOURCE_DIR}/sample_lib_config.h.in"
    "${CMAKE_BINARY_DIR}/sample_lib_config.h"
    @ONLY
)

##------------------ CMake file generation -- END ---------------

##----------------- CXX related configuration -- START -------------

# Set CXX standard
set(CMAKE_CXX_STANDARD 14)

# Drop out if required standard is not supported
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# CXX extensions
set(CMAKE_CXX_EXTENSIONS OFF)

# Append extra flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pedantic -Wextra")

##----------------- CXX related configuration -- END -------------

##----------------- Setup target - START -------------

# Add sources to the library
add_library(${LIB_NAME}
            STATIC
            ${PROJECT_SOURCE_DIR}/sample_lib.cc)

# Set include directories
target_include_directories(sample_lib PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(sample_lib PUBLIC ${CMAKE_BINARY_DIR})

# Install
install(TARGETS sample_lib DESTINATION lib)
install(FILES ${PROJECT_SOURCE_DIR}/sample_lib.h DESTINATION include)
install(FILES ${CMAKE_BINARY_DIR}/sample_lib_config.h DESTINATION include)

##----------------- Setup target - END -------------

##----------------- Setup .pc file -- START -------------

# Set env for text replacement in .pc template
set(prefix         ${CMAKE_INSTALL_PREFIX})
set(target_lib     ${LIB_NAME})
set(verison        ${VERSION_STRING})

# Generate .pc file from template
configure_file(
    "${PROJECT_SOURCE_DIR}/${LIB_NAME}.pc.in"
    "${CMAKE_BINARY_DIR}/${LIB_NAME}.pc"
    @ONLY
)

# Install
install(FILES ${CMAKE_BINARY_DIR}/${LIB_NAME}.pc DESTINATION lib/pkgconfig)

##----------------- Setup .pc file -- END -------------

