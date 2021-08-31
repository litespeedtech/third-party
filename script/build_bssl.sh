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
#git checkout bfe527fa35735e8e045cbfb42b012e13ca68f9cf
#git checkout 251b5169fd44345f455438312ec4e18ae07fd58c
#git checkout b117a3a0b7bd11fe6ebd503ec6b45d6b910b41a1
# HTTP/3 v1 and ID-34 support
git checkout a2278d4d2cabe73f6663e3299ea7808edfa306b9

rm -rf build

patch -p1 < ../../patches/boringssl/bssl_lstls.patch
patch -p1 < ../../patches/boringssl/bssl_inttypes.patch
patch -p1 < ../../patches/boringssl/bssl_max_early_data_sz.patch
#patch -p1 < ../../patches/boringssl/bssl_no_eoed.patch
sed -i -e "s/-Werror//" CMakeLists.txt

mkdir build
cd build
cmake ../ -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_C_FLAGS="-fPIC" -DCMAKE_CXX_FLAGS="-fPIC"
#cmake ../ -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_C_FLAGS="-fPIC -DOPENSSL_C11_ATOMIC" -DCMAKE_CXX_FLAGS="-fPIC -DOPENSSL_C11_ATOMIC"
make -j4

cp crypto/libcrypto.a ../../../lib
cp ssl/libssl.a    ../../../lib
cp decrepit/libdecrepit.a ../../../lib

cd ..
cp -r include/openssl ../../include/

