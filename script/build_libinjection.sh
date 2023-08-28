
cd `dirname "$0"`
cd ..
PREFIX=`pwd`


cd src/libinjection
git reset --hard
git checkout v3.10.0
cd src

PYFULLVER=$(/usr/bin/env python --version)
PYVER=$(echo "$PYFULLVER" | cut -c 8)
if [ "$PYVER" = "3" ]; then
   echo "Change python scripts to use Python2"
   sed -i 's~/usr/bin/env python~/usr/bin/env python2~' *.py
fi
cd ..
make
cp src/*.h ../../include
cp src/libinjection.a ../../lib

cd ../..
ranlib lib/libinjection.a
