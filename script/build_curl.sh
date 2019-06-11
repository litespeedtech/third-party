
#! /bin/bash

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -d "curl" ] ; then
    git clone https://github.com/curl/curl.git
fi

    cd curl

    ./buildconf 
    LIBS=-lpthread ./configure --prefix=$PREFIX --with-ssl=$PREFIX --with-brotli=no  --enable-shared=no --enable-ldap=no
    make
    make install

