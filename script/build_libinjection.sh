
cd `dirname "$0"`
cd ..
PREFIX=`pwd`


cd src/libinjection
git reset --hard
git checkout v3.10.0

make
cp src/*.h ../../include
cp src/libinjection.a ../../lib

cd ../..
ranlib lib/libinjection.a
