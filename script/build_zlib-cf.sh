

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -d "zlib-cf" ]  ; then
    git clone https://github.com/cloudflare/zlib.git zlib-cf
fi
    
cd zlib-cf
CFLAGS="-fPIC -O3" ./configure --prefix=$PREFIX --static

make install

