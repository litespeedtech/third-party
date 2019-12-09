
#! /bin/bash

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -d "curl" ] ; then
    git clone https://github.com/curl/curl.git
fi

    cd curl
    git checkout curl-7_65_3
    ./buildconf 
    LIBS=-lpthread ./configure --prefix=$PREFIX --with-ssl=$PREFIX --with-brotli=no  --enable-shared=no --enable-ldap=no --without-nghttp2 --without-nghttp3
    make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17'
    make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17' install

