#! /bin/bash

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

    CPPFLAGS="-fPIC $CPPFLAGS" ./configure --prefix=$PREFIX --with-python=no --disable-shared
    make -j4

    
    if [ ! -f ./.libs/libxml2.a  ] ; then
        echo Something wrong, libxml2.a  not exist
        exit 0
    fi 
    make install    


