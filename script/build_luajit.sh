#!/bin/sh

cd `dirname "$0"`
cd ..
CUR_PREFIX=`pwd`
cd src

cd luajit

make install PREFIX=$CUR_PREFIX CFLAGS="-fPIC -O3" 

cd ../..
cp patches/libtool/libluajit-5.1.la lib/libluajit-5.1.la
echo "libdir='$CUR_PREFIX/lib'" >> lib/libluajit-5.1.la
ln -sf libluajit-5.1.a lib/libluajit.a

rm -f lib/libluajit*.so*

