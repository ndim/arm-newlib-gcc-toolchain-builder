#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$REAL_PREFIX" == "" ]] ; then
	echo "You need to set: TARGET and REAL_PREFIX"; exit 0;
fi

setup_builddir gdb

(cd "$tool_builddir" && \
    ../gdb_sources/configure \
    -v \
    --quiet \
    --prefix="$REAL_PREFIX" \
    --target="$TARGET" \
    --enable-interwork \
    --enable-multilib \
    --with-gnu-ld \
    --with-gnu-as \
    --disable-werror )

quieten_make

run_make all install
