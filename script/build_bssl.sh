#!/bin/sh
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src


if [ ! -d "boringssl" ]; then
    git clone https://github.com/google/boringssl.git
fi

if [ -d "go" ]; then

PATH=$PWD/go/bin:$PATH
echo $PATH

fi

cd boringssl
git reset --hard
git checkout master
git pull

#git checkout 49de1fc291
git checkout bfe527fa35735e8e045cbfb42b012e13ca68f9cf

rm -rf build

#patch -p1 < ../bssl_lstls.patch
patch -p1 < ../../patches/boringssl/bssl_inttypes.patch
patch -p1 < ../../patches/boringssl/bssl_max_early_data_sz.patch
#patch -p1 < ../../patches/boringssl/bssl_no_eoed.patch

mkdir build
cd build
cmake ../ -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_C_FLAGS="-fPIC" -DCMAKE_CXX_FLAGS="-fPIC"
make -j4
cd ssl
make -j4
cd ../decrepit
make -j4
cd ..


cp crypto/libcrypto.a ../../../lib
cp ssl/libssl.a    ../../../lib
cp decrepit/libdecrepit.a ../../../lib

cd ..
cp -r include/openssl ../../include/

