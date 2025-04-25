
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src


if [ ! -d yajl-2.1.0 ]; then
    ../script/build_yajl.sh
    cd src
fi


if [ ! -d ModSecurity ]; then
    git clone https://github.com/SpiderLabs/ModSecurity
fi
cd ModSecurity
git reset --hard
git checkout -b v3/master origin/v3/master
git pull
git checkout v3.0.14

export PATH=/home/build/tools/bin/:$PATH
sh build.sh
rm -rf others/mbedtls
git submodule init
git submodule update
CPPFLAGS="-fPIC $CPPFLAGS" ./configure --with-yajl=$PREFIX --with-maxmind=$PREFIX --disable-shared --enable-static --with-pcre=$PREFIX --with-curl=$PREFIX --with-libxml=$PREFIX --with-lmdb=$PREFIX --with-lua=$PREFIX --disable-examples
if [ "$(uname -s)" = "FreeBSD" ] ; then
    gmake -j$(nproc)
else
    make -j$(nproc)
fi

cp -r headers/modsecurity ../../include/
cp src/.libs/libmodsecurity.a ../../lib/


