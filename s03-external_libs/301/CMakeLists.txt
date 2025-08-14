cmake_minimum_required(VERSION 3.1)
project(sample_format_app)

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

add_executable(sample_format_app ${PROJECT_SOURCE_DIR}/sample-format.cc)
install(TARGETS sample_format_app DESTINATION bin)

add_executable(sample_atomic_app ${PROJECT_SOURCE_DIR}/sample-atomic.cc)
install(TARGETS sample_atomic_app DESTINATION bin)

add_executable(sample_chrono_app ${PROJECT_SOURCE_DIR}/sample-chrono.cc)
install(TARGETS sample_chrono_app DESTINATION bin)

add_executable(sample_random_app ${PROJECT_SOURCE_DIR}/sample-random.cc)
install(TARGETS sample_random_app DESTINATION bin)

add_executable(sample_signal_app ${PROJECT_SOURCE_DIR}/sample-signal.cc)
install(TARGETS sample_signal_app DESTINATION bin)

add_executable(sample_regex_app ${PROJECT_SOURCE_DIR}/sample-regex.cc)
install(TARGETS sample_regex_app DESTINATION bin)

add_executable(sample_datetime_app ${PROJECT_SOURCE_DIR}/sample-datetime.cc)
install(TARGETS sample_datetime_app DESTINATION bin)

add_executable(sample_locale_app ${PROJECT_SOURCE_DIR}/sample-locale.cc)
install(TARGETS sample_locale_app DESTINATION bin)

add_executable(sample_programoptions_app ${PROJECT_SOURCE_DIR}/sample-programoptions.cc)
install(TARGETS sample_programoptions_app DESTINATION bin)

add_executable(sample_unittest_app ${PROJECT_SOURCE_DIR}/sample-unittest.cc)
install(TARGETS sample_unittest_app DESTINATION bin)

##----------------- Setup target - END -------------

##----------------- Setup Boost -- START -------------

set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)

find_package(Boost 1.63.0 REQUIRED COMPONENTS system)
target_include_directories(sample_format_app PRIVATE ${BOOST_INCLUDE_DIRS})
target_link_libraries(sample_format_app Boost::system)

find_package(Boost 1.63.0 REQUIRED COMPONENTS thread atomic)
target_include_directories(sample_atomic_app PRIVATE ${BOOST_INCLUDE_DIRS})
target_link_libraries(sample_atomic_app Boost::thread Boost::atomic)

find_package(Boost 1.63.0 REQUIRED COMPONENTS chrono)
target_include_directories(sample_chrono_app PRIVATE ${BOOST_INCLUDE_DIRS})
target_link_libraries(sample_chrono_app Boost::chrono)

find_package(Boost 1.63.0 REQUIRED COMPONENTS random)
target_include_directories(sample_random_app PRIVATE ${BOOST_INCLUDE_DIRS})
target_link_libraries(sample_random_app Boost::random)

find_package(Boost 1.63.0 REQUIRED COMPONENTS signals)
target_include_directories(sample_signal_app PRIVATE ${BOOST_INCLUDE_DIRS})
target_link_libraries(sample_signal_app Boost::signals)

find_package(Boost 1.63.0 REQUIRED COMPONENTS regex)
target_include_directories(sample_regex_app PRIVATE ${BOOST_INCLUDE_DIRS})
target_link_libraries(sample_regex_app Boost::regex)

find_package(Boost 1.63.0 REQUIRED COMPONENTS date_time)
target_include_directories(sample_datetime_app PRIVATE ${BOOST_INCLUDE_DIRS})
target_link_libraries(sample_datetime_app Boost::date_time)

find_package(Boost 1.63.0 REQUIRED COMPONENTS locale)
target_include_directories(sample_locale_app PRIVATE ${BOOST_INCLUDE_DIRS})
target_link_libraries(sample_locale_app Boost::locale)

find_package(Boost 1.63.0 REQUIRED COMPONENTS program_options)
target_include_directories(sample_programoptions_app PRIVATE ${BOOST_INCLUDE_DIRS})
target_link_libraries(sample_programoptions_app Boost::program_options)

find_package(Boost 1.63.0 REQUIRED COMPONENTS unit_test_framework)
target_include_directories(sample_unittest_app PRIVATE ${BOOST_INCLUDE_DIRS})
target_link_libraries(sample_unittest_app Boost::unit_test_framework)
target_compile_definitions(sample_unittest_app PRIVATE BOOST_TEST_DYN_LINK) # Boost lib will be used as dynamic lib

##----------------- Setup Boost -- END -------------
