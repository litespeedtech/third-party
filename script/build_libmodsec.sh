
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src


if [ ! -d lloyd-yajl-66cb08c ]; then
    # Install YAJL2
    wget http://github.com/lloyd/yajl/tarball/2.1.0 -O yajl-2.1.0.tar.gz
    tar -xvzf yajl-2.1.0.tar.gz
    cd lloyd-yajl-66cb08c
    ./configure -p $PREFIX

    cd build
    cmake EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17 -DCMAKE_POSITION_INDEPENDENT_CODE=on' -DCMAKE_INSTALL_PREFIX="$PREFIX" -DCMAKE_C_FLAGS="-fPIC" ..
    cd ..

    make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17' install
    cd ../..
    cp patches/libtool/libyajl.la lib/libyajl.la
    echo "libdir='$PREFIX/lib'" >> lib/libyajl.la
    mv lib/libyajl_s.a lib/libyajl.a
    rm -f lib/libyajl.so*

    #yum install -y doxygen  flex
    #./build_autotool.sh
    cd src
fi


if [ ! -d ModSecurity ]; then
    git clone https://github.com/SpiderLabs/ModSecurity
fi
cd ModSecurity
git reset --hard
git checkout -b v3/master origin/v3/master
git pull

export PATH=/home/build/tools/bin/:$PATH
sh build.sh
git submodule init
git submodule update
CPPFLAGS="-fPIC $CPPFLAGS" ./configure --with-yajl=$PREFIX --with-geoip=$PREFIX --with-maxmind=$PREFIX --disable-shared --enable-static --with-pcre=$PREFIX --with-curl=$PREFIX --with-libxml=$PREFIX --with-lmdb=$PREFIX --with-lua=$PREFIX --disable-examples
make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17'

cp -r headers/modsecurity ../../include/
cp src/.libs/libmodsecurity.a ../../lib/


