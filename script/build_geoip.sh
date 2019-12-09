
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src


if [ ! -d "geoip-api-c" ]; then
    git clone https://github.com/maxmind/geoip-api-c.git
fi
cd geoip-api-c
git reset --hard
git checkout v1.6.11

./bootstrap
CPPFLAGS="-I../../include" ./configure --prefix=$PREFIX --enable-shared=no
	make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17' install
