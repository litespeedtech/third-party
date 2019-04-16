cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(third-party)

set_property(DIRECTORY PROPERTY EP_BASE ${CMAKE_BINARY_DIR}/subprojects)

include(ExternalProject)

ExternalProject_Add(boringssl
  GIT_REPOSITORY
    https://boringssl.googlesource.com/boringssl
  GIT_TAG
    32e59d2d3264e4e104b355ef73663b8b79ac4093
  PATCH_COMMAND
    patch -p1 -s -i ${CMAKE_SOURCE_DIR}/patches/boringssl/bssl_max_early_data_sz.patch
        COMMAND
    patch -p1 -s -i ${CMAKE_SOURCE_DIR}/patches/boringssl/bssl_no_eoed.patch
        COMMAND
    patch -p1 -s -i ${CMAKE_SOURCE_DIR}/patches/boringssl/bssl_inttypes.patch
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${CMAKE_SOURCE_DIR}
    -DCMAKE_BUILD_TYPE=RelWithDebInfo
    -DCMAKE_C_FLAGS="-fPIC"
    -DCMAKE_CXX_FLAGS="-fPIC"
  CMAKE_CACHE_ARGS
    -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
  BUILD_ALWAYS
    1
  INSTALL_COMMAND
    mkdir -p ${CMAKE_SOURCE_DIR}/include ${CMAKE_SOURCE_DIR}/lib
          COMMAND
    ln -svf ${CMAKE_SOURCE_DIR}/subprojects/Source/boringssl/include/openssl ${CMAKE_SOURCE_DIR}/include
          COMMAND
    ln -svf ${CMAKE_SOURCE_DIR}/subprojects/Build/boringssl/ssl/libssl.a ${CMAKE_SOURCE_DIR}/lib
          COMMAND
    ln -svf ${CMAKE_SOURCE_DIR}/subprojects/Build/boringssl/crypto/libcrypto.a ${CMAKE_SOURCE_DIR}/lib
          COMMAND
    ln -svf ${CMAKE_SOURCE_DIR}/subprojects/Build/boringssl/decrepit/libdecrepit.a ${CMAKE_SOURCE_DIR}/lib
)

ExternalProject_Add(brotli
  GIT_REPOSITORY
    https://github.com/google/brotli.git
  GIT_TAG
    v1.0.5
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${CMAKE_SOURCE_DIR}
  CMAKE_CACHE_ARGS
    -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
  BUILD_ALWAYS
    1
  INSTALL_COMMAND
    make install
)
