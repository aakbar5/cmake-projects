cmake_minimum_required(VERSION 3.1)
project(sample_app)

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

##----------------- Setup target - START -------------

# Add source files to the program executable
add_executable(sample_app ${PROJECT_SOURCE_DIR}/sample.cc)

# Install
install(TARGETS sample_app DESTINATION bin)

##----------------- Setup target - END -------------

##----------------- ExternalProject - START -----------
# ExternalProject: Create custom targets to build projects in external trees.

add_executable(unit_test sample_unittest.cc)

# Google benchmarking needs pthread
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

include(ExternalProject)
ExternalProject_Add(
	gtest
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/third_party
	GIT_REPOSITORY https://github.com/google/googletest.git
	GIT_TAG e2239ee6043f73722e7aa812a459f54a28552929
	CMAKE_ARGS -DCMAKE_BUILD_TYPE=RELEASE
	INSTALL_COMMAND ""
	LOG_DOWNLOAD 1
    LOG_BUILD 1
	LOG_INSTALL 1
)
ExternalProject_Get_property(gtest SOURCE_DIR)
ExternalProject_Get_Property(gtest BINARY_DIR)
set(gtest_BINARY_DIR ${BINARY_DIR})
set(gtest_SOURCE_DIR ${SOURCE_DIR})
set(gtest_INCLUDE_DIR ${gtest_SOURCE_DIR}/googletest/include)
set(gtest_LIBRARY ${gtest_BINARY_DIR}/lib/libgtest.a)
set(gtest_LIBRARY_MAIN ${gtest_BINARY_DIR}/lib/libgtest_main.a)

add_dependencies(unit_test gtest)
target_include_directories(unit_test PRIVATE ${gtest_INCLUDE_DIR})
target_link_libraries(unit_test PRIVATE Threads::Threads ${gtest_LIBRARY} ${gtest_LIBRARY_MAIN})

##----------------- ExternalProject - END -----------
