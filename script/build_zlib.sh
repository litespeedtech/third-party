

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -d "zlib" ]  ; then
    git clone https://github.com/madler/zlib.git
fi
    
cd zlib
CFLAGS="-fPIC -O3" ./configure --prefix=$PREFIX --static

make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17' install

