#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX_REAL" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX_REAL"; exit 0;
fi

setup_dirs gcc

run_configure \
    --target="$TARGET" \
    --prefix="$PREFIX_REAL" \
    --with-gnu-as \
    --with-gnu-ld \
    --enable-languages=c \
    --enable-multilib \
    --with-newlib \
    --with-system-zlib \
    --with-headers="${BUILDSOURCES}/newlib_sources/newlib/libc/include" \
    --disable-werror

run_make all install
