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

# HTTP/3 v1 and ID-34 support
#git checkout a9670a8b476470e6f874fef3554e8059683e1413
git checkout 9fc1c33e9c21439ce5f87855a6591a9324e569fd

rm -rf build

patch -p1 < ../../patches/boringssl/bssl_lstls.patch
patch -p1 < ../../patches/boringssl/bssl_inttypes.patch
#patch -p1 < ../../patches/boringssl/bssl_max_early_data_sz.patch
#patch -p1 < ../../patches/boringssl/bssl_no_eoed.patch
sed -i -e "s/-Werror//" CMakeLists.txt

mkdir build
cd build
if [ "$(uname -m)" = "aarch64" ]; then
    cmake ../ -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_C_FLAGS="-fPIC" -DCMAKE_CXX_FLAGS="-fPIC" -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
else
    cmake ../ -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_C_FLAGS="-fPIC" -DCMAKE_CXX_FLAGS="-fPIC"
fi
#cmake ../ -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_C_FLAGS="-fPIC -DOPENSSL_C11_ATOMIC" -DCMAKE_CXX_FLAGS="-fPIC -DOPENSSL_C11_ATOMIC"
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

