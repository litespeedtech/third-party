#!/bin/sh

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -d "flatbuffers" ]; then
    git clone https://github.com/google/flatbuffers.git
fi
cd flatbuffers

git reset --hard
git checkout v1.8.0

mkdir out && cd out
cmake EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17 -DCMAKE_POSITION_INDEPENDENT_CODE=on' ..
make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17'

cp libflatbuffers.a ../../../lib
cp flatc  ../../../bin

cd ..
cp -r include/flatbuffers ../../include

