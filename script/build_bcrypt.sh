
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src


if [ ! -d "libbcrypt" ]; then
    git clone --depth 1 https://github.com/litespeedtech/libbcrypt.git
fi
cd libbcrypt
make
cp bcrypt.h ../../include
cp bcrypt.a ../../lib/libbcrypt.a
