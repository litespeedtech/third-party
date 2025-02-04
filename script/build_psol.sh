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

    cat << EOF > psol-$PSOL_VER/include/pagespeed/kernel/base/scoped_ptr.h
/**
* Due the compiling issue, this file was updated from the original file.
*/
#ifndef PAGESPEED_KERNEL_BASE_SCOPED_PTR_H_
#define PAGESPEED_KERNEL_BASE_SCOPED_PTR_H_
#include "base/memory/scoped_ptr.h"

namespace net_instaweb {
template<typename T> class scoped_array : public scoped_ptr<T[]> {
public:
    scoped_array() : scoped_ptr<T[]>() {}
    explicit scoped_array(T* t) : scoped_ptr<T[]>(t) {}
};
}
#endif

EOF

fi

