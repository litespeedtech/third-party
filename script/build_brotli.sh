#!/bin/sh

cd `dirname "$0"`
cd ..
PREFIX=`pwd`

cd src/brotli

mkdir out
cd out
cmake .. -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PREFIX
make install

