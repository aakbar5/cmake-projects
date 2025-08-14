#!/bin/bash
set -x

CURRENT_DIR=`pwd`

echo "-- Run CMake test"
echo "   Current directory: $CURRENT_DIR"

function test_101() {
    echo "---- Test # s01-app/101"
    src_folder=s01-app/101
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    echo "------ Build" && \
    mkdir -p $build_folder && \
    cmake -B $build_folder -H$src_folder && \
    make -C $build_folder && \
    echo "------ Execute" && \
    $build_folder/sample_app
}

function test_102() {
    echo "---- Test # s01-app/102"
    src_folder=s01-app/102
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for type in "Debug" "Release" "Custom"; do
        build_folder=$src_folder/build_$type

        echo "------ Build # $type" && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -H$src_folder && \
        make -C  $build_folder && \
        echo "------ Execute" && \
        $build_folder/sample_app
    done
}

function test_103() {
    echo "---- Test # s01-app/103"
    src_folder=s01-app/103
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type" && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
        make -C  $build_folder && \
        make -C  $build_folder install && \
        echo "------ Execute" && \
        $install_folder/bin/sample_app
    done
}

function test_104() {
    echo "---- Test # s01-app/104"
    src_folder=s01-app/104
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type" && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
        make -C  $build_folder && \
        make -C  $build_folder install && \
        echo "------ Execute" && \
        $install_folder/bin/sample_app
    done
}

function test_105() {
    echo "---- Test # s01-app/105"
    src_folder=s01-app/105
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type"
        mkdir -p $build_folder
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder
        make -C  $build_folder
        make -C  $build_folder install

        echo "------ Execute"
        $install_folder/bin/sample_app
    done
}

function test_106() {
    echo "---- Test # s01-app/106"
    src_folder=s01-app/106
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type"
        mkdir -p $build_folder
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder
        make -C  $build_folder
        make -C  $build_folder install

        echo "------ Execute"
        $install_folder/bin/sample_app
    done
}

function test_107() {
    echo "---- Test # s01-app/107"
    src_folder=s01-app/107
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type" && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
        make -C  $build_folder && \
        make -C  $build_folder install && \
        echo "------ Execute" && \
        $install_folder/bin/sample_app
    done
}

function test_201() {
    echo "---- Test # s02-library/201"
    src_folder=s02-library/201
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type" && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
        make -C  $build_folder && \
        make -C  $build_folder install
    done
}

function test_202() {
    echo "---- Test # s02-library/202"
    src_folder=s02-library/202
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type" && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
        make -C  $build_folder && \
        make -C  $build_folder install
    done
}

function test_203() {
    echo "---- Test # s02-library/203"
    src_folder=s02-library/203
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    test_201

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type" && \
        export LIB_INSTALL_HOME=`pwd`/$install_folder && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
        make -C  $build_folder && \
        make -C  $build_folder install
        echo "------ Execute" && \
        $install_folder/bin/sample_app
    done
}

function test_204() {
    echo "---- Test # s02-library/204"
    src_folder=s02-library/204
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    test_202

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type" && \
        export LIB_INSTALL_HOME=`pwd`/$install_folder && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
        make -C  $build_folder && \
        make -C  $build_folder install
        echo "------ Execute" && \
        LD_LIBRARY_PATH=$LIB_INSTALL_HOME/lib $install_folder/bin/sample_app
    done
}

function test_205() {
    echo "---- Test # s02-library/205"
    src_folder=s02-library/205
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for libtype in "008" "202"; do
        test_$libtype

        for type in "Release" "Debug"; do
            build_folder=$src_folder/build_$type
            install_folder=$src_folder/install_$type

            echo "------ Build # $type" && \
            export LIB_PKG_HOME=`pwd`/$libtype/$install_folder && \
            mkdir -p $build_folder && \
            cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
            make -C  $build_folder && \
            make -C  $build_folder install
            echo "------ Execute" && \
            LD_LIBRARY_PATH=$LIB_INSTALL_HOME/lib $install_folder/bin/sample_app
        done
    done
}

function test_206() {
    echo "---- Test # s02-library/206"
    src_folder=s02-library/206
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type" && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
        make -C  $build_folder && \
        make -C  $build_folder install
    done
}

function test_207() {
    echo "---- Test # s02-library/207"
    src_folder=s02-library/207
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    test_206

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type" && \
        export LIB_CMAKE_HOME=`pwd`/$install_folder/lib/cmake && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
        make -C  $build_folder && \
        make -C  $build_folder install && \
        echo "------ Execute" && \
        $install_folder/bin/sample_app
    done
}

function test_208() {
    echo "---- Test # s02-library/208"
    src_folder=s02-library/208
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type" && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
        make -C  $build_folder && \
        make -C  $build_folder install
    done
}

function test_209() {
    echo "---- Test # s02-library/209"
    src_folder=s02-library/209
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    test_208

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type" && \
        export LIB_CMAKE_HOME=`pwd`/$install_folder/lib/cmake && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
        make -C  $build_folder && \
        make -C  $build_folder install && \
        echo "------ Execute" && \
        LD_LIBRARY_PATH=`pwd`/$install_folder/lib $install_folder/bin/sample_app
    done
}

function test_210() {
    echo "---- Test # s02-library/210"
    src_folder=s02-library/210
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for lib in "SHARED" "STATIC"; do
        for type in "Release" "Debug"; do
            build_folder=$src_folder/build_$lib_$type
            install_folder=$src_folder/install_$lib_$type

            echo "------ Build # $type" && \
            mkdir -p $build_folder && \
            cmake -B $build_folder -DLIBARARY_TYPE=$lib -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
            make -C  $build_folder && \
            make -C  $build_folder install
        done
    done
}

function test_211() {
    echo "---- Test # s02-library/211"
    src_folder=s02-library/211
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for type in "Release" "Debug"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type" && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
        make -C  $build_folder && \
        make -C  $build_folder install
    done
}

function test_301() {
    echo "---- Test # s03-external_libs/301"
    src_folder=s03-external_libs/301
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    # Ref: based on test_107
    for type in "Release"; do
        build_folder=$src_folder/build_$type
        install_folder=$src_folder/install_$type

        echo "------ Build # $type" && \
        mkdir -p $build_folder && \
        cmake -B $build_folder -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
        make -C  $build_folder && \
        make -C  $build_folder install && \
        echo "------ Execute" && \
        $install_folder/bin/sample_format_app && \
        $install_folder/bin/sample_atomic_app && \
        $install_folder/bin/sample_chrono_app && \
        $install_folder/bin/sample_random_app && \
        $install_folder/bin/sample_signal_app && \
        $install_folder/bin/sample_regex_app && \
        $install_folder/bin/sample_datetime_app && \
        $install_folder/bin/sample_locale_app && \
        $install_folder/bin/sample_programoptions_app && \
        $install_folder/bin/sample_unittest_app
    done
}

function test_401() {
    echo "---- Test # s04-misc/401"
    src_folder=s04-misc/401
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    for pack in "ZIP" "TGZ" "DEB"; do
        for type in "Release"; do
            build_folder=$src_folder/build_$type_$pack
            install_folder=$src_folder/install_$type

            echo "------ Build # $type" && \
            mkdir -p $build_folder && \
            cmake -B $build_folder -DPACKAGE_TYPE=$pack -DCMAKE_BUILD_TYPE=$type -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
            make -C  $build_folder && \
            make -C  $build_folder package && \
            make -C  $build_folder install
        done
    done
}

function test_402() {
    echo "---- Test # s04-misc/402"
    src_folder=s04-misc/402
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    mkdir -p $build_folder && \
    cmake -B $build_folder -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
    make -C  $build_folder && \
    make -C  $build_folder res && \
    make -C  $build_folder install
}

function test_403() {
    echo "---- Test # s04-misc/403"
    src_folder=s04-misc/403
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    mkdir -p $build_folder && \
    cmake -B $build_folder -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
    make -C  $build_folder && \
    make -C  $build_folder install
}

function test_404() {
    echo "---- Test # s04-misc/404"
    src_folder=s04-misc/404
    build_folder=$src_folder/build
    install_folder=$src_folder/install

    mkdir -p $build_folder && \
    cmake -B $build_folder -DCMAKE_INSTALL_PREFIX=$install_folder -H$src_folder && \
    make -C  $build_folder && \
    make -C  $build_folder install && \
    $build_folder/sample_app && \
    $build_folder/unit_test
}

# -------------------------------
# Cmake tests
test_101
test_102
test_103
test_104
test_105
test_106
test_107
test_201
test_202
test_203
test_204
test_205
test_206
test_207
test_208
test_209
test_210
test_211
test_301
test_401
test_402
test_403
test_404
