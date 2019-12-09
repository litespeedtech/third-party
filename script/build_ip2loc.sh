#!/bin/sh

cd `dirname "$0"`
cd ..
PREFIX=`pwd`


cd src/ip2loc

git reset --hard
git checkout 8.0.8

autoreconf -i -v --force
./configure --prefix=$PREFIX -enable-shared=no 
make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17' install


