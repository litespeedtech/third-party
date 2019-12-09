
cd `dirname "$0"`
cd ..
PREFIX=`pwd`


cd src/libinjection
git reset --hard
git checkout v3.10.0

make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17'
cp src/*.h ../../include
cp src/libinjection.a ../../lib

cd ../..
ranlib lib/libinjection.a
