
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -d "lmdb" ]  ; then
    git clone https://github.com/LMDB/lmdb.git
fi
    
    cd lmdb/libraries/liblmdb/
    XCFLAGS=-fPIC make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17'
    
    if [ ! -f liblmdb.a ] ; then
        echo Something wrong, liblmdb.a not exist
        exit 0
    fi
    
    cp *.h ../../../../include
    cp *.a ../../../../lib
    cd ../../../../
    cp patches/libtool/liblmdb.la lib/liblmdb.la
    echo "libdir='$PREFIX/lib'" >> lib/liblmdb.la

