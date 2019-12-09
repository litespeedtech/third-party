

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

cd udns
./configure
make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17'
cp udns.h ../../include
cp libudns.a ../../lib
cd ../..
ranlib lib/libudns.a

