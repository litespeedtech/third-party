#!/bin/sh
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src


if [ ! -d "boringssl" ]; then
    git clone https://github.com/raihan001/boringssl.git
fi

if [ -d "go" ]; then

PATH=$PWD/go/bin:$PATH
echo $PATH

fi

cd boringssl
git reset --hard
git checkout master
git pull

#git checkout 32e59d2d3264e4e104b355ef73663b8b79ac4093
git checkout 49de1fc291

rm -rf build

#patch -p1 < ../bssl_lstls.patch
patch -p1 < ../../patches/boringssl/bssl_inttypes.patch
patch -p1 < ../../patches/boringssl/bssl_max_early_data_sz.patch
#patch -p1 < ../../patches/boringssl/bssl_no_eoed.patch

mkdir build
cd build
cmake EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17 -DCMAKE_POSITION_INDEPENDENT_CODE=on' -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_C_FLAGS="-fPIC" -DCMAKE_CXX_FLAGS="-fPIC" ../ 
make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17'
cd ssl
make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17'
cd ../decrepit
make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17'
cd ..


cp crypto/libcrypto.a ../../../lib
cp ssl/libssl.a    ../../../lib
cp decrepit/libdecrepit.a ../../../lib

cd ..
cp -r include/openssl ../../include/

