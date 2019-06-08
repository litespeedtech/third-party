

cd `dirname "$0"`
cd ..
PREFIX=`pwd`

cd src/zlib
CFLAGS="-fPIC" ./configure --prefix=$PREFIX --static

make install

