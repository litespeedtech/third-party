#!/bin/sh

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -d "quickjs" ]; then
    git clone https://github.com/quickjs-ng/quickjs.git
fi
cd quickjs

#git reset --hard
#git checkout v0.13.0

mkdir build
cd build
cmake .. -DCMAKE_C_FLAGS="-fPIC"
cmake --build .
cd ..

cp build/*.a ../../lib

cp quickjs*.h ../../include

