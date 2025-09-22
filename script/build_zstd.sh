
cd `dirname "$0"`
cd ..
VER=1.5.7
PREFIX=`pwd`
cd src


if [ ! -d "zstd-$VER" ]; then
   wget https://github.com/facebook/zstd/releases/download/v$VER/zstd-$VER.tar.gz
   tar xvfz zstd-$VER.tar.gz
   rm zstd
   ln -sf zstd-$VER zstd
fi
cd zstd


cd build/cmake
mkdir build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX=$PREFIX -DZSTD_LEGACY_SUPPORT=OFF -DZSTD_BUILD_SHARED=OFF -DZSTD_MULTITHREAD_SUPPORT=ON
make install
