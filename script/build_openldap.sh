
cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src


if [ ! -d openldap ]; then
git clone https://github.com/openldap/openldap.git

fi

cd openldap
git checkout OPENLDAP_REL_ENG_2_4_46


LD_FLAGS="-L$PREFIX/lib -L/usr/local/lib -ldecrepit -lpthread"
C_FLAGS="-I$PREFIX/include -I/usr/local/include"

LDFLAGS="$LD_FLAGS" CPPFLAGS="$C_FLAGS" ./configure  --prefix=$PREFIX --enable-slapd=no --with-cyrus-sasl=no --with-tls=yes --with-threads=yes --enable-shared=no
make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17' depend
make -j4 EXTRA_CMAKE_OPTIONS='-DCMAKE_C_COMPILER=arm64-linux-gcc -DCMAKE_CXX_COMPILER=arm64-linux-gnu-g++ -DCXX_STANDARD_REQUIRED=c++17' install

#cp libraries/liblber/.libs/liblber.a ../../lib
#cp libraries/libldap/.libs/libldap.a ../../lib

#cp include/lber.h include/lber_types.h include/ldap_cdefs.h include/ldap.h include/ldap_features.h ../../include

