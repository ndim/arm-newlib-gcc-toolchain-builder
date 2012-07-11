#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$REAL_PREFIX" == "" || "$BOOT_PREFIX" == "" ]] ; then
	echo "You need to set: TARGET and REAL_PREFIX and BOOT_PREFIX"; exit 0;
fi

setup_builddir newlib

(cd "$tool_builddir" && \
    ../newlib_sources/configure -v --quiet --target=$TARGET --prefix=$REAL_PREFIX \
    --disable-newlib-supplied-syscalls --enable-interwork --enable-multilib \
    --with-gnu-ld --with-gnu-as --disable-newlib-io-float \
   --disable-werror )

quieten_make

run_make all install \
    CC_FOR_TARGET=$BOOT_PREFIX/bin/arm-none-eabi-gcc \
    AS_FOR_TARGET=$BOOT_PREFIX/bin/arm-none-eabi-as \
    LD_FOR_TARGET=$BOOT_PREFIX/bin/arm-none-eabi-ld \
    AR_FOR_TARGET=$BOOT_PREFIX/bin/arm-none-eabi-ar \
    RANLIB_FOR_TARGET=$BOOT_PREFIX/bin/arm-none-eabi-ranlib
