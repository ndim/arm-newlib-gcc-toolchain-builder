#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX_REAL" == "" || "$PREFIX_BOOT" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX_REAL and PREFIX_BOOT"; exit 0;
fi

setup_dirs newlib

# $tool_builddir is a temporary random dir you need to build newlib
# ../newlib_sources/ is the dir containing newlib sources
# $PREFIX_REAL is where your destiny cross compiler will be installed to
# $PREFIX_BOOT is the path where the compiler to compile the newlib is installed
run_configure \
    --target="$TARGET" \
    --prefix="$PREFIX_REAL" \
    --disable-newlib-supplied-syscalls \
    --enable-multilib \
    --with-gnu-ld \
    --with-gnu-as \
    --disable-newlib-io-float \
    --disable-werror

run_make all install \
    CC_FOR_TARGET="$PREFIX_BOOT/bin/${TARGET}-gcc" \
    AS_FOR_TARGET="$PREFIX_BOOT/bin/${TARGET}-as" \
    LD_FOR_TARGET="$PREFIX_BOOT/bin/${TARGET}-ld" \
    AR_FOR_TARGET="$PREFIX_BOOT/bin/${TARGET}-ar" \
    RANLIB_FOR_TARGET="$PREFIX_BOOT/bin/${TARGET}-ranlib"
