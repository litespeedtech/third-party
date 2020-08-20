
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src


    # Install YAJL2
    wget http://github.com/lloyd/yajl/tarball/2.1.0 -O yajl-2.1.0.tar.gz
    tar -xvzf yajl-2.1.0.tar.gz
    cd lloyd-yajl-66cb08c
    ./configure -p $PREFIX

    cd build
    cmake -DCMAKE_INSTALL_PREFIX="$PREFIX" -DCMAKE_C_FLAGS="-fPIC" ..
    make install
    cd ..

    cd ../..
    cp patches/libtool/libyajl.la lib/libyajl.la
    echo "libdir='$PREFIX/lib'" >> lib/libyajl.la
    mv lib/libyajl_s.a lib/libyajl.a
    rm -f lib/libyajl.so*

    #yum install -y doxygen  flex
    #./build_autotool.sh


