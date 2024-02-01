
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

PACKAGE=libaio-0.3.113

if [ ! -d $PACKAGE ]; then
	wget --no-check-certificate https://pagure.io/libaio/archive/libaio-0.3.113/libaio-libaio-0.3.113.tar.gz    
	mv libaio-libaio-0.3.113.tar.gz libaio-0.3.113.tar.gz
fi
tar xvfz $PACKAGE.tar.gz
mv libaio-libaio-0.3.113 libaio-0.3.113
rm $PACKAGE.tar.gz

cd $PACKAGE
make prefix=$PREFIX install

