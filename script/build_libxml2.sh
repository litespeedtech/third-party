#! /bin/sh

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src
VERSION=2.14.2
if [ ! -e "libxml2-$VERSION" ] ; then
    wget https://download.gnome.org/sources/libxml2/2.14/libxml2-$VERSION.tar.xz
    tar xvfJ libxml2-$VERSION.tar.xz
    ln -sf libxml2-$VERSION libxml2
fi
    cd libxml2

    CPPFLAGS="-fPIC $CPPFLAGS" ./configure --prefix=$PREFIX --with-python=no --disable-shared --with-lzma=no
    make

    
    if [ ! -f ./.libs/libxml2.a  ] ; then
        echo Something wrong, libxml2.a  not exist
        exit 0
    fi 
    make install    


