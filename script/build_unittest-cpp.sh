
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

cd unittest-cpp
make

mkdir -p ../../include/unittest-cpp/Posix
cp src/*.h ../../include/unittest-cpp
cp src/Posix/*.h ../../include/unittest-cpp/Posix
cp libUnitTest++.a ../../lib
cd ../..
ranlib lib/libUnitTest++.a

