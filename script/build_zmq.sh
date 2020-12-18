#! /bin/bash

cd `dirname "$0"`
cd ..
PREFIX=`pwd`

cd src

#rm -rf libzmq

if [ ! -d libzmq ]; then
    git clone https://github.com/zeromq/libzmq.git
fi
    cd libzmq 

    git reset --hard
    git pull
    git checkout v4.3.3

    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=$PREFIX -DBUILD_SHARED=OFF -DCMAKE_BUILD_TYPE=Debug -DWITH_PERF_TOOL=OFF -DZMQ_BUILD_TESTS=OFF ..
    make 
#    ./autogen.sh 
#    ./configure --prefix=$PREFIX --enable-shared=no
    make install

