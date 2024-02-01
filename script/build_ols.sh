#!/bin/sh
BUILD_LIBS="brotli zlib bssl bcrypt expat libaio ip2loc libmaxminddb luajit pcre psol udns bcrypt lmdb curl libxml2 yajl libmodsec"

cd `dirname "$0"`
cd ..

if [ ! -d lib64 ]; then
    mkdir lib64
fi

git submodule update --init
cd script

for BUILD_LIB in $BUILD_LIBS
do 
   ./build_$BUILD_LIB.sh
done
