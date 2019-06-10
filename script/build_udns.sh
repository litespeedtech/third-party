

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

cd udns
./configure
make
cp udns.h ../../include
cp libudns.a ../../lib
cd ../..
ranlib lib/libudns.a

