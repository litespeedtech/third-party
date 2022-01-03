
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

PACKAGE=pcre-8.43

if [ ! -d $PACKAGE ]; then
    wget https://ftp.exim.org/pub/pcre/$PACKAGE.tar.gz
fi
tar xvfz $PACKAGE.tar.gz
rm $PACKAGE.tar.gz

cd $PACKAGE
./configure --prefix=$PREFIX --enable-jit --enable-unicode-properties --enable-utf --with-pic --with-match-limit=100000 --enable-shared=no
make install

