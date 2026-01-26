
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ "x$1" != "x" ]; then
    PACKAGE=php-$1
else   
    PACKAGE=php-8.5.2
fi

if [ ! -d $PACKAGE ]; then
    wget https://www.php.net/distributions/$PACKAGE.tar.gz
fi
tar xvfz $PACKAGE.tar.gz
rm $PACKAGE.tar.gz

cd $PACKAGE
./configure PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ --prefix=$PREFIX --disable-all --enable-litespeed --enable-session --enable-posix --enable-xml --with-libexpat-dir=$PREFIX --with-zlib=$PREFIX --enable-sockets --enable-bcmath --enable-json --with-libxml=$PREFIX
make -j4
if [ -f sapi/litespeed/lsphp ]; then
    cp sapi/litespeed/lsphp ../../bin/lsphp
else
    cp sapi/litespeed/php ../../bin/lsphp
fi
