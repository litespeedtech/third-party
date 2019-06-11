
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -d "lmdb" ]  ; then
    git clone https://github.com/LMDB/lmdb.git
fi
    
    cd lmdb/libraries/liblmdb/
    make
    
    if [ ! -f liblmdb.a ] ; then
        echo Something wrong, liblmdb.a not exist
        exit 0
    fi
    
    cp *.h ../../../../include
    cp *.a ../../../../lib
    cd ../../../
    cp patches/libtool/liblmdb.la lib/liblmdb.la
    echo "libdir='$PREFIX/lib'" >> lib/liblmdb.la

