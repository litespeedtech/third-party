
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src


if [ ! -d "isa-l" ]; then
    git clone https://github.com/intel/isa-l.git
fi
cd isa-l
git reset --hard
git checkout v2.26.0

./autogen.sh
#CFLAGS="-O0 -g" ./configure --prefix=$PREFIX --enable-shared=no --enable-debug=yes
./configure --prefix=$PREFIX --enable-shared=no 
make install

