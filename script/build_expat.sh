
cd `dirname "$0"`
cd ..
PREFIX=`pwd`

cd src/libexpat

git checkout R_2_2_6
cd expat

./buildconf.sh
./configure --prefix=$PREFIX --without-xmlwf --without-docbook --enable-shared=no
make install

