#!/bin/sh

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -d "phc-winner-argon2" ]; then
    git clone https://github.com/P-H-C/phc-winner-argon2.git
fi
cd phc-winner-argon2

#git reset --hard
#git checkout v0.13.0

make PREFIX=../../
make install PREFIX=../../

