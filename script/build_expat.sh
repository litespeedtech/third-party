
cd `dirname "$0"`
cd ..
PREFIX=`pwd`

cd src/

git clone https://github.com/libexpat/libexpat.git

cd libexpat

git checkout R_2_2_6
cd expat

./buildconf.sh
./configure --prefix=$PREFIX --without-xmlwf --without-docbook --enable-shared=no
make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17' install

