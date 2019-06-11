#!/bin/sh
BUILD_LIBS="brotli bssl expat geoip ip2loc libmaxminddb luajit pcre psol udns unittest-cpp zlib lmdb curl libmodsec"

cd `dirname "$0"`


for BUILD_LIB in $BUILD_LIBS
do 
   ./build_$BUILD_LIB.sh
done
