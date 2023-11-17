#!/bin/sh
set -x
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

# abseil is a requirement for re2
if [ ! -d "abseil-cpp" ]; then
    git clone https://github.com/abseil/abseil-cpp.git
fi
cd abseil-cpp
git checkout lts_2023_08_02
if [ ! -d "build" ]; then
    mkdir build
fi
cd build
#cmake -DABSL_BUILD_TESTING=ON -DABSL_USE_GOOGLETEST_HEAD=ON -DCMAKE_CXX_STANDARD=14 ..
cmake -DCMAKE_CXX_STANDARD=14 .. -DCMAKE_INSTALL_PREFIX=../../..
cmake --build . --target install
#ctest
cd ..
cd ..
cd ../lib
ar -rcT libabsl.a libabsl_*.a
ranlib libabsl.a
cd ../src

if [ ! -d "re2" ]; then
    git clone https://github.com/google/re2.git
fi
cd re2

git reset --hard
git checkout 2023-08-01

if [ ! -d "build" ]; then
    mkdir build
fi
cd build
cmake .. -DCMAKE_PREFIX_PATH=../../.. -DCMAKE_INSTALL_PREFIX=../../..
cmake --build . --target install

cd ..

