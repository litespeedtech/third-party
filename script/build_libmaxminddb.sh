
cd `dirname "$0"`
cd ..
PREFIX=`pwd`


cd src/libmaxminddb
git reset --hard
git pull
git checkout 1.5.2

./bootstrap
CPPFLAGS="-I../include" ./configure --disable-tests --prefix=$PREFIX -enable-shared=no --disable-binaries

make install
cp src/libmaxminddb.la $PREFIX/lib
cp include/maxminddb_config.h $PREFIX/include
