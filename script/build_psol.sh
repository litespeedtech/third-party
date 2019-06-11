#! /bin/sh
#
# This script is to download PSOL and extract it to right location
#
#

cd `dirname "$0"`
cd ..
PREFIX=`pwd`
cd src

PSOL_VER=1.11.33.4
TARGET=$PSOL_VER.tar.gz

if [ ! -f psol-$PSOL_VER/include/out/Release/obj/gen/net/instaweb/public/version.h ] ; then

    DL=`which curl`
    DLCMD="$DL -O -k "
    if [ ! -f $TARGET ]; then
        $DLCMD https://dl.google.com/dl/page-speed/psol/$TARGET
    fi
    tar -xzvf $TARGET # expands to psol/
    mv psol psol-$PSOL_VER
    cd ..
    ln -sf src/psol-$PSOL_VER psol-$PSOL_VER
fi

