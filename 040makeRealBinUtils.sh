#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX_REAL" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX_REAL"; exit 0;
fi

setup_dirs binutils

run_configure \
    --target="$TARGET" \
    --prefix="$PREFIX_REAL" \
    --enable-multilib \
    --with-gnu-ld \
    --with-gnu-as \
    --disable-werror

run_make all install
