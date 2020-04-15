
cd `dirname "$0"`
cd ..
PREFIX=`pwd`

cd src/

git clone https://github.com/libexpat/libexpat.git

cd libexpat

git checkout R_2_2_9
cd expat

rm -rf build

mkdir build
cd build 
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$PREFIX -DEXPAT_SHARED_LIBS=OFF ..

#./buildconf.sh
#./configure --prefix=$PREFIX --without-xmlwf --without-docbook --enable-shared=no
make install

