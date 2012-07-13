#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX_BOOT" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX_BOOT"; exit 0;
fi

setup_dirs bootgcc gcc

run_configure \
    -v \
    --quiet \
    --target="$TARGET" \
    --prefix="$PREFIX_BOOT" \
    --with-newlib \
    --without-headers \
    --with-gnu-as \
    --with-gnu-ld \
    --disable-shared \
    --enable-languages=c \
    --disable-werror

quieten_make

run_make all-gcc install-gcc
