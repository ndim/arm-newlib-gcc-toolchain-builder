#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX_BOOT" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX_BOOT"; exit 0;
fi

setup_dirs bootbinutils binutils

run_configure \
    --target="$TARGET" \
    --prefix="$PREFIX_BOOT" \
    --enable-multilib \
    --with-gnu-ld \
    --with-gnu-as \
    --disable-werror

run_make all install
