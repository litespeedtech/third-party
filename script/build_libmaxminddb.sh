
cd `dirname "$0"`
cd ..
PREFIX=`pwd`


cd src/libmaxminddb
git reset --hard
git checkout 1.3.2

./bootstrap
CPPFLAGS="-I../include" ./configure --disable-tests --prefix=$PREFIX -enable-shared=no --disable-binaries

make install
