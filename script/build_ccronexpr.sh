

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -d "ccronexpr" ]  ; then
    git clone https://github.com/staticlibs/ccronexpr.git
fi
    
cd ccronexpr
cat >CMakeLists.txt <<EOL
cmake_minimum_required(VERSION 2.8)
project(ccronexpr)
add_library(ccronexpr STATIC ccronexpr.c)
EOL
cmake .
make
cp libccronexpr.a ../../lib/
cp ccronexpr.h ../../include/


