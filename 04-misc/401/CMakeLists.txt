cmake_minimum_required(VERSION 3.1)
project(sample_app)

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
    "${PROJECT_SOURCE_DIR}/sample_config.h.in"
    "${CMAKE_BINARY_DIR}/sample_config.h"
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

# Add source files to the program executable
add_executable(sample_app
    ${PROJECT_SOURCE_DIR}/sample.cc
    ${PROJECT_SOURCE_DIR}/util/util.cc
)

# Set include directories
target_include_directories(sample_app PRIVATE ${CMAKE_SOURCE_DIR}/util)
target_include_directories(sample_app PRIVATE ${CMAKE_BINARY_DIR})

# Install
install(TARGETS sample_app DESTINATION bin)

##----------------- Setup target - END -------------

##----------------- Setup CPack - START -------------
if(NOT PACKAGE_TYPE)
    set(PACKAGE_TYPE "DEBG") # Possible options: DEB, TGZ, ZIP
endif()

set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
set(CPACK_PACKAGE_VENDOR "Test vendor")
set(CPACK_PACKAGE_DESCRIPTION "Test descrption")
set(CPACK_PACKAGE_HOMEPAGE_URL "www.test.com")
set(CPACK_PACKAGE_VERSION_MAJOR ${VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${VERSION_PATCH})
if(UNIX)
    if(PACKAGE_TYPE MATCHES "DEB")
        set(CPACK_GENERATOR "DEB")
        set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Test vendor")
        set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "x86_64")
        set(CPACK_DEBIAN_PACKAGE_DEPENDS "libstdc++6")
        # SET(CPACK_DEBIAN_PACKAGE_DEPENDS "libglib2.0-dev (>=2.24.1),libtool,curl,protobuf")
    elseif(PACKAGE_TYPE MATCHES "ZIP")
        set(CPACK_GENERATOR "ZIP")
    elseif(PACKAGE_TYPE MATCHES "TGZ")
        set(CPACK_GENERATOR "TGZ")
    endif()
else()
set(CPACK_GENERATOR "ZIP")
endif()

include (CPack)
##----------------- Setup CPack - END -------------
