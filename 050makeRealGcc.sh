#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX_REAL" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX_REAL"; exit 0;
fi

setup_dirs gcc

run_configure \
    -v \
    --quiet \
    --target="$TARGET" \
    --prefix="$PREFIX_REAL" \
    --with-gnu-as \
    --with-gnu-ld \
    --enable-languages=c \
    --enable-interwork \
    --enable-multilib \
    --with-newlib \
    --with-system-zlib \
    --with-headers="${BUILDSOURCES}/newlib_sources/newlib/libc/include" \
    --disable-werror

# switch "with-system-zlib":
# if we build gcc & newlib for bare metal targets we do not have any linker file nor any crt.o
# therefore we must avoid some gcc configure scripts trying to do a link test.
# up to now there is no direct solution for that circumstance. as a workaround we link to the
# system installed copy of the Zlib library rather than gccs internal version
# for further information you may check:
# http://gcc.gnu.org/ml/gcc/2008-03/msg00515.html

run_make all install
