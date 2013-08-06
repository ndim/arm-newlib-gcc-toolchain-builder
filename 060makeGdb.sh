#!/bin/bash


# note:  libexpat must be specified to get full support for memory maps sent to GDB from OpenOCD. you must install the "expat-devel"


set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX_REAL" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX_REAL"; exit 0;
fi

setup_dirs gdb

run_configure \
    --prefix="$PREFIX_REAL" \
    --target="$TARGET" \
    --enable-multilib \
    --with-gnu-ld \
    --with-gnu-as \
    --with-libexpat \
    --disable-werror

run_make all install
