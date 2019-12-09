
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

cd unittest-cpp
make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17'

mkdir -p ../../include/unittest-cpp/Posix
cp src/*.h ../../include/unittest-cpp
cp src/Posix/*.h ../../include/unittest-cpp/Posix
cp libUnitTest++.a ../../lib
cd ../..
ranlib lib/libUnitTest++.a

