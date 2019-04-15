cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(third-party)

set_property(DIRECTORY PROPERTY EP_BASE ${CMAKE_BINARY_DIR}/subprojects)

include(ExternalProject)

ExternalProject_Add(${PROJECT_NAME}_brotli
  SOURCE_DIR
    ${CMAKE_CURRENT_LIST_DIR}/src
  GIT_REPOSITORY
    https://github.com/google/brotli.git
  GIT_TAG
    v1.0.5
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${CMAKE_SOURCE_DIR}
  BUILD_ALWAYS
    1
  INSTALL_COMMAND
    make install
)
