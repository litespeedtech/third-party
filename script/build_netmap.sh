#!/bin/sh

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src
if [ ! -d "netmap" ]  ; then
    git clone https://github.com/luigirizzo/netmap.git
    cd netmap
    git checkout 00335cd4b6347e6ecc79a67ab200ba2e050c9646
    cd ..
fi
cd ..
if [ ! -d include/net ]; then
    mkdir include/net
fi
cp src/netmap/sys/net/* include/net

