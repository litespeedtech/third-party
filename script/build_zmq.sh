#! /bin/bash

cd `dirname "$0"`
cd ..
PREFIX=`pwd`

cd src

if [ ! -d libzmq ]; then
    git clone https://github.com/zeromq/libzmq.git
fi
    cd libzmq/
    ./autogen.sh 
    ./configure --prefix=$PREFIX --enable-shared=no
    make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17' install

