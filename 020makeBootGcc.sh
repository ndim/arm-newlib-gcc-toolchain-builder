#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX_BOOT" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX_BOOT"; exit 0;
fi

setup_dirs bootgcc gcc

run_configure \
    --target="$TARGET" \
    --prefix="$PREFIX_BOOT" \
    --without-headers \
    --with-gnu-as \
    --with-gnu-ld \
    --disable-shared \
    --enable-languages=c \
    --disable-werror

run_make all-gcc install-gcc
