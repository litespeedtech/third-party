
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ "x$1" != "x" ]; then
    PACKAGE=php-$1
else   
    PACKAGE=php-8.5.2
fi

LSAPI_VERSION=8.3

if [ ! -d $PACKAGE ]; then
    wget https://www.php.net/distributions/$PACKAGE.tar.gz
    tar xvfz $PACKAGE.tar.gz
    rm $PACKAGE.tar.gz
fi

cd $PACKAGE

if [ ! -f php-litespeed-${LSAPI_VERSION}.tgz ]; then
    wget https://www.litespeedtech.com/packages/lsapi/php-litespeed-${LSAPI_VERSION}.tgz
fi 

cd sapi
if [ -e litespeed/Makefile.frag ] ; then
        mv -f litespeed/Makefile.frag litespeed/Makefile.frag.package
fi

tar -xzf "../php-litespeed-${LSAPI_VERSION}.tgz" -C litespeed --strip-components=1

if [ -e litespeed/Makefile.frag.package ] ; then
        mv -f litespeed/Makefile.frag.package litespeed/Makefile.frag
fi
cd ..

./configure PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/ --prefix=$PREFIX --disable-all \
	--with-litespeed --enable-litespeed --enable-session --enable-posix \
	--enable-xml --with-libexpat-dir=$PREFIX --with-zlib=$PREFIX \
	--enable-sockets --enable-bcmath --enable-json \
	--with-libxml=$PREFIX --enable-hash
make -j4
if [ -f sapi/litespeed/lsphp ]; then
    cp sapi/litespeed/lsphp ../../bin/lsphp
else
    cp sapi/litespeed/php ../../bin/lsphp
fi
