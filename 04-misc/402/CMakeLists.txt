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

##----------------- custom_command (tap default build events) - START -----------
# Add a custom build rule to the generated build system (Tap build events).

add_custom_command(TARGET sample_app
    PRE_BUILD
    COMMENT "Custom command @ pre-build..."
    COMMAND ${CMAKE_COMMAND} -E echo "How are you?"
    VERBATIM
)

add_custom_command(TARGET sample_app
    PRE_LINK
    COMMENT "Custom command @ pre-link..."
    COMMAND ${CMAKE_COMMAND} -E echo "I am good - Thanks"
    VERBATIM
)

add_custom_command(TARGET sample_app
    POST_BUILD
    COMMENT "Custom command @ post-build..."
    COMMAND ${CMAKE_COMMAND} -E echo "Lets go on ride"
    VERBATIM
)

##----------------- custom_command (tap default build events) - END -----------

##----------------- custom_command & custom_target - START -----------

# Custom command can be used to generate files
set(RESOURCE_SETUP "${CMAKE_CURRENT_BINARY_DIR}/resources.tar")
add_custom_command(
    OUTPUT ${RESOURCE_SETUP}
    COMMENT "Setup resources"
    COMMAND ${CMAKE_COMMAND} -E echo "\tCreate resource folder"
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_BINARY_DIR}/resources
    COMMAND ${CMAKE_COMMAND} -E echo "\tCopy contents..."
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${PROJECT_SOURCE_DIR}/sample.cc ${CMAKE_CURRENT_BINARY_DIR}/resources
    COMMAND ${CMAKE_COMMAND} -E echo "\tCompress resource folder..."
    COMMAND ${CMAKE_COMMAND} -E tar czf ${CMAKE_CURRENT_BINARY_DIR}/resources.tar ${CMAKE_CURRENT_BINARY_DIR}/resources
    COMMAND ${CMAKE_COMMAND} -E echo "\tMD5Sum of the output"
    COMMAND ${CMAKE_COMMAND} -E md5sum ${CMAKE_CURRENT_BINARY_DIR}/resources.tar
    VERBATIM
)

# Above created command target is not visible to user
# so let's create a target which can be used by using `make res`
add_custom_target(res
    DEPENDS ${RESOURCE_SETUP}
)

##----------------- custom_command & custom_target - END -----------
