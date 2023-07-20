
#! /bin/bash

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -d "curl" ] ; then
    git clone https://github.com/curl/curl.git
fi

    cd curl
    git pull
    git checkout curl-7_88_1
    ./buildconf 
    CFLAGS="-fPIC" LIBS=-lpthread ./configure --prefix=$PREFIX --with-ssl=$PREFIX --with-brotli=no  --enable-shared=no --enable-ldap=no --without-nghttp2 --without-nghttp3
    make
    make install

