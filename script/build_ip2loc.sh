#!/bin/sh

cd `dirname "$0"`
cd ..
PREFIX=`pwd`


cd src/ip2loc

git reset --hard
git pull
git checkout 8.0.9

autoreconf -i -v --force
./configure --prefix=$PREFIX -enable-shared=no 
make install


