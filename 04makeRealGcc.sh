#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX"; exit 0;
fi

check_builddir gcc

(cd "$tool_builddir" && rm -rf * && \
../gcc_sources/configure -v --quiet --target=$TARGET --prefix=$PREFIX \
   --with-gnu-as --with-gnu-ld --enable-languages=c \
   --enable-interwork --enable-multilib --with-newlib --with-system-zlib \
   --with-headers=${PREFIX}/newlib_sources/newlib/libc/include \
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
(cd "$tool_builddir" && make all install 2>&1 ) | tee $BUILDSOURCES/make.log
