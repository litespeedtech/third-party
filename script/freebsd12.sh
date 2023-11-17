
#!/bin/sh
OS=`uname -s`
if [ "x$OS" = "xFreeBSD" ]; then

export CC=gcc12
export CXX=g++12
export CPP="gcc12 -E"

fi

