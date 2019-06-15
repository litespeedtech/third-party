#!/bin/sh
BUILD_LIBS="brotli zlib bssl expat geoip ip2loc libmaxminddb luajit pcre psol udns unittest-cpp lmdb openldap flatbuffers libinjection zmq curl libxml2 libmodsec"

cd `dirname "$0"`
cd ..

git submodule update --init
cd script

for BUILD_LIB in $BUILD_LIBS
do 
   ./build_$BUILD_LIB.sh
done
