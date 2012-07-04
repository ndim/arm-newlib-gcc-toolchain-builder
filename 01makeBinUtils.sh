#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX"; exit 0;
fi

setup_builddir binutils

(cd "$tool_builddir" && \
../binutils_sources/configure -v --quiet  --target=$TARGET --prefix=$PREFIX \
    --enable-interwork --enable-multilib --with-gnu-ld --with-gnu-as \
    --disable-werror )

quieten_make

# note, make.log contains the stderr output of the build.
(cd "$tool_builddir" && make all install 2>&1 ) | tee $BUILDSOURCES/make.log
