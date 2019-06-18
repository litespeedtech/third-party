
#!/bin/sh
OS=`uname -s`
if [ "x$OS" = "xFreeBSD" ]; then

export CC=gcc49
export CXX=g++49
export CPP="gcc49 -E"

fi

