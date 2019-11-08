
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
    cmake -DCMAKE_INSTALL_PREFIX="$PREFIX" -DCMAKE_C_FLAGS="-fPIC" ..
    cd ..

    make install
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
make -j4

cp -r headers/modsecurity ../../include/
cp src/.libs/libmodsecurity.a ../../lib/


