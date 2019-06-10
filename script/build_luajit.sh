#!/bin/sh

cd `dirname "$0"`
cd ..
CUR_PREFIX=`pwd`
cd src

cd luajit-2.0

make install PREFIX=$CUR_PREFIX



