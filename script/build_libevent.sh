#! /bin/bash

cd `dirname "$0"`
cd ..
PREFIX=`pwd`

cd src


if [ ! -d libevent ]; then
    git clone https://github.com/libevent/libevent.git
fi
    cd libevent

    git reset --hard
    git pull
    git checkout release-2.1.12-stable

    cmake -B build  -DEVENT__DISABLE_OPENSSL:BOOL=OFF -DEVENT__LIBRARY_TYPE:STRING=STATIC -DCMAKE_INSTALL_PREFIX=../../
    cd build
    make -j4 
    make install

