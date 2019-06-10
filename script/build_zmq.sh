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
    make install

