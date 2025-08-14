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

include(ExternalProject)
ExternalProject_Add(project_zlib
    BUILD_IN_SOURCE     1
    PREFIX              zlib

    # Use local downloaded one
    URL                 ${PROJECT_SOURCE_DIR}/zlib.zip
    URL_MD5             bad764f0beefb432508ce6c186b8b0dc

    # SVN link can be used to download code, see #1

    # GIT_REPOSITORY      https://github.com/madler/zlib.git
    # GIT_TAG             v1.2.11

    CONFIGURE_COMMAND   ./configure --static
    BUILD_COMMAND       "make"
    INSTALL_COMMAND     ""      # see #2
    LOG_BUILD           1
    LOG_INSTALL         1
)

# Extract property of our external project to findout its source dir
# See #3
ExternalProject_Get_Property(project_zlib SOURCE_DIR)
target_include_directories(sample_app PRIVATE
    ${CMAKE_BINARY_DIR}
    ${SOURCE_DIR}       # Pass on our external project to resolve headers
)

# Pass on library of our external to linker
# Use #3 to link external project library
target_link_libraries(sample_app  ${SOURCE_DIR}/libz.a)

##
# - 1
# In my testing, I was using something following:
#   SVN_REPOSITORY  "http://sample/svn/link"
#   SVN_REVSION     "145"
# During code extraction, cmake was unable to find out specified revision number
# and was ending with error, it turned out be that I should have something like following:
#   SVN_REPOSITORY  "http://sample/svn/link"
#   SVN_REVSION     "-r  145"
#
#
# - 2
# As per documentation of zlib, make install can be used to install
# build files so I was using INSTALL_COMMAND "make install" but it was
# failing; If you won't specify INSTALL_COMMAND, cmake was trying to
# install it. To avoid its installation empty string has been used.
#
#
# - 3
# Sadly we can not use find_package with ExternalProject_Add so that's why
# one to manually link up different bits & pieces required to make use
# of the external project. There is another way to pass external project
# libraries to the target.
#
#[[
# Create library target and marked it as import type
add_library(ext_proj_lib STATIC IMPORTED)
# Set library name and path to be used for library target created above
set_target_properties(ext_proj_lib PROPERTIES IMPORTED_LOCATION "${SOURCE_DIR}/libz.a")
# Add add_dependencies onto the external project for this library
add_dependencies(ext_proj_lib project_zlib)
# add_dependencies of library to to the application
add_dependencies(sample_app ext_proj_lib)
# Ask to link library with application
target_link_libraries(sample_app ext_proj_lib)
]]

##----------------- ExternalProject - END -----------