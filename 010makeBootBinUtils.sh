#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX_BOOT" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX_BOOT"; exit 0;
fi

setup_builddir binutils

(cd "$tool_builddir" && \
    ../binutils_sources/configure \
    -v \
    --quiet \
    --target="$TARGET" \
    --prefix="$PREFIX_BOOT" \
    --enable-interwork \
    --enable-multilib \
    --with-gnu-ld \
    --with-gnu-as \
    --disable-werror )

quieten_make

run_make all install
