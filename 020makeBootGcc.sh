#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX2" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX2"; exit 0;
fi

setup_builddir bootgcc

(cd "$tool_builddir" && \
../gcc_sources/configure -v --quiet --target=$TARGET --prefix=$PREFIX2 \
   --with-newlib --without-headers --with-gnu-as \
   --with-gnu-ld --disable-shared --enable-languages=c \
   --disable-werror )

quieten_make

# note, make.log contains the stderr output of the build.
(cd "$tool_builddir" && make all-gcc install-gcc 2>&1 ) | tee $BUILDSOURCES/make.log
