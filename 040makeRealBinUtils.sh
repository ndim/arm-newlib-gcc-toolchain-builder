#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX_REAL" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX_REAL"; exit 0;
fi

setup_builddir binutils

(cd "$tool_builddir" && \
    ../binutils_sources/configure \
    -v \
    --quiet \
    --target="$TARGET" \
    --prefix="$PREFIX_REAL" \
    --enable-interwork \
    --enable-multilib \
    --with-gnu-ld \
    --with-gnu-as \
    --disable-werror )

quieten_make

run_make all install
