#!/bin/sh
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ $1 != 'ossl' ]; then

cd boringssl
cd build

cp crypto/libcrypto.a ../../../lib
cp ssl/libssl.a    ../../../lib
cp decrepit/libdecrepit.a ../../../lib

cd ..
rm -r ../../include/openssl
cp -r include/openssl ../../include/

else

cd openssl

rm -rf ../../include/openssl
mkdir ../../include/openssl
cp -R -L include/openssl ../../include/
cp libssl.a ../../lib
cp libcrypto.a ../../lib


fi
