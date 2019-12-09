
cd `dirname "$0"`
cd ..
PREFIX=`pwd`


cd src/libmaxminddb
git reset --hard
git checkout 1.3.2

./bootstrap
CPPFLAGS="-I../include" ./configure --disable-tests --prefix=$PREFIX -enable-shared=no --disable-binaries

make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17' install
cp src/libmaxminddb.la $PREFIX/lib
