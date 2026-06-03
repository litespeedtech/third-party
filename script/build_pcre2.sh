
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

PACKAGE=pcre2-10.45

if [ ! -d $PACKAGE ]; then
    wget https://github.com/PCRE2Project/pcre2/releases/download/$PACKAGE/$PACKAGE.tar.gz
fi
tar xvfz $PACKAGE.tar.gz
rm $PACKAGE.tar.gz

cd $PACKAGE
./configure --prefix=$PREFIX --enable-jit --enable-pcre2-8 --enable-unicode --with-pic --with-match-limit=100000 --enable-shared=no --enable-static
make install
