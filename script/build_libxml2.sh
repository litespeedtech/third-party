#! /bin/sh

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -e "libxml2" ] ; then
    wget ftp://xmlsoft.org/libxml2/libxml2-2.9.8.tar.gz
    tar xvfz libxml2-2.9.8.tar.gz
    ln -sf libxml2-2.9.8 libxml2
fi
    cd libxml2

    CPPFLAGS="-fPIC $CPPFLAGS" ./configure --prefix=$PREFIX --with-python=no --disable-shared --with-lzma=no
    make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17'

    
    if [ ! -f ./.libs/libxml2.a  ] ; then
        echo Something wrong, libxml2.a  not exist
        exit 0
    fi 
    make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17' install    


