#!/bin/sh

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

if [ ! -d "argon2-cpp" ]; then
    git clone https://github.com/zpalmtree/argon2-cpp.git
    cd argon2-cpp
    git submodule update --init
else
    cd argon2-cpp
fi

#git reset --hard
#git checkout v0.13.0

mkdir build
cd build
cmake .. -DCMAKE_C_FLAGS="-fPIC" -DENABLE_NVIDIA=OFF
cmake --build .
cd ..

cp build/src/Argon2/*.a ../../lib
cp build/src/Blake2/*.a ../../lib
if [ -e build/src/cpu_features/libcpu_features.a ]; then
    cp build/src/cpu_features/libcpu_features.a ../../lib
fi
if libIntrinsics=$(find . -name libIntrinsics.a); then
    cp $libIntrinsics ../../lib
fi

if [ ! -d ../../include/Argon2 ]; then
    mkdir ../../include/Argon2
fi
cp src/Argon2/*.h ../../include/Argon2

if [ ! -d ../../include/Blake2 ]; then
    mkdir ../../include/Blake2
fi
cp src/Blake2/*.h ../../include/Blake2

