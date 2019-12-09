#!/bin/sh

cd `dirname "$0"`
cd ..
CUR_PREFIX=`pwd`
cd src

rm -rf luajit
git clone https://github.com/cbaylis/luajit-aarch64.git
mv luajit-aarch64 luajit
cd luajit
make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17' install PREFIX=$CUR_PREFIX CFLAGS="-fPIC -O3" 

cd ../..
cp patches/libtool/libluajit-5.1.la lib/libluajit-5.1.la
echo "libdir='$CUR_PREFIX/lib'" >> lib/libluajit-5.1.la

rm -f lib/libluajit*.so.*

