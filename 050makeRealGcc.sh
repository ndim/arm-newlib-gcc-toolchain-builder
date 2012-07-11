#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$REAL_PREFIX" == "" ]] ; then
	echo "You need to set: TARGET and REAL_PREFIX"; exit 0;
fi

setup_builddir gcc

(cd "$tool_builddir" && rm -rf * && \
../gcc_sources/configure -v --quiet --target=$TARGET --prefix=$REAL_PREFIX \
   --with-gnu-as --with-gnu-ld --enable-languages=c \
   --enable-interwork --enable-multilib --with-newlib --with-system-zlib \
   --with-headers=${REAL_PREFIX}/newlib_sources/newlib/libc/include \
   --disable-werror )

# switch "with-system-zlib":
# if we build gcc & newlib for bare metal targets we do not have any linker file nor any crt.o
# therefore we must avoid some gcc configure scripts trying to do a link test.
# up to now there is no direct solution for that circumstance. as a workaround we link to the
# system installed copy of the Zlib library rather than gccs internal version
# for further information you may check:
# http://gcc.gnu.org/ml/gcc/2008-03/msg00515.html

quieten_make

# note, make.log contains the stderr output of the build.
(cd "$tool_builddir" && make all install 2>&1 ) | log_output
