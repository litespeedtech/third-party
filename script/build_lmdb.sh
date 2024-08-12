
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src
REMOTE_URL='https://github.com/LMDB/lmdb.git'
#'https://git.openldap.org/openldap/openldap.git'

if [ -d "lmdb" ]  ; then
    CUR_REMOTE=`git config --file=./lmdb/.git/config --get remote.origin.url`
    if [ "${REMOTE_URL}" = "${CUR_REMOTE}" ]; then
        echo 'Remote is set up, OK'
    else
        echo 'Using old remote lmdb, delete and re-fetch.'
        rm -rf ./lmdb
    fi
fi

if [ ! -d "lmdb" ]  ; then
    git clone https://git.openldap.org/openldap/openldap.git lmdb
fi

cd lmdb
git checkout master
git pull
#git checkout LMDB_0.9.27B
    
    cd libraries/liblmdb/
    XCFLAGS=-fPIC make
    
    if [ ! -f liblmdb.a ] ; then
        echo Something wrong, liblmdb.a not exist
        exit 0
    fi
    
    cp *.h ../../../../include
    cp *.a ../../../../lib
    cp *.so ../../../../lib
    cd ../../../../
 #   cp patches/libtool/liblmdb.la lib/liblmdb.la
 #   echo "libdir='$PREFIX/lib'" >> lib/liblmdb.la

