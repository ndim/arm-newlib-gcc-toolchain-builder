#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIXREAL" == "" || "$PREFIXBOOT" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX and PREFIXBOOT"; exit 0;
fi

setup_builddir newlib

# $tool_builddir is a temporary random dir you need to build newlib
# ../newlib_sources/ is the dir containing newlib sources
# $PREFIXREAL is where your destiny cross compiler will be installed to
# $PREFIXBOOT is the path where the compiler to compile the newlib is installed
(cd "$tool_builddir" && \
    ../newlib_sources/configure -v --quiet --target=$TARGET --prefix=$PREFIXREAL \
    --disable-newlib-supplied-syscalls --enable-interwork --enable-multilib \
    --with-gnu-ld --with-gnu-as --disable-newlib-io-float \
   --disable-werror )

quieten_make

(cd "$tool_builddir" && make all install CC_FOR_TARGET=$PREFIXBOOT/bin/$TARGET-gcc \
                                         AS_FOR_TARGET=$PREFIXBOOT/bin/$TARGET-as \
                                         LD_FOR_TARGET=$PREFIXBOOT/bin/$TARGET-ld \
                                         AR_FOR_TARGET=$PREFIXBOOT/bin/$TARGET-ar \
                                         RANLIB_FOR_TARGET=$PREFIXBOOT/bin/$TARGET-ranlib \
                                         2>&1 ) | tee $BUILDSOURCES/make.log

