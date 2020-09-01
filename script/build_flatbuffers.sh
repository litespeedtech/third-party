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
git checkout v1.11.0

mkdir out && cd out
cmake ..
make -j2

cp libflatbuffers.a ../../../lib
cp flatc  ../../../bin

cd ..
cp -r include/flatbuffers ../../include

