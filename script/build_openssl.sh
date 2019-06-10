#!/bin/sh

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -d "openssl" ]; then
    git clone https://github.com/openssl/openssl.git
fi

#RELEASE=OpenSSL_1_1_1a
#RELEASE=OpenSSL_1_1_0i
RELEASE=OpenSSL_1_0_2p
#DEBUG="-d"

cd openssl
git reset --hard

git checkout master
git pull
git checkout $RELEASE

make clean
./config $DEBUG --prefix=$PREFIX --openssldir=$PREFIX/lib/openssl -DPURIFY no-shared no-dso
make depend
make -j4

rm -rf ../../include/openssl
mkdir ../../include//openssl
cp -R -L include/openssl ../../include/
cp libssl.a ../../lib
cp libcrypto.a ../../lib



