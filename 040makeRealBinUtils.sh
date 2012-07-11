#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$REAL_PREFIX" == "" ]] ; then
	echo "You need to set: TARGET and REAL_PREFIX"; exit 0;
fi

setup_builddir binutils

(cd "$tool_builddir" && \
../binutils_sources/configure -v --quiet  --target=$TARGET --prefix=$REAL_PREFIX \
    --enable-interwork --enable-multilib --with-gnu-ld --with-gnu-as \
    --disable-werror )

quieten_make

run_make all install
