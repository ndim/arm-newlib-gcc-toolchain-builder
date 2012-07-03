#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX"; exit 0;
fi

(cd binutils_build ; \
../binutils_sources/configure -v --quiet  --target=$TARGET --prefix=$PREFIX \
    --enable-interwork --enable-multilib --with-gnu-ld --with-gnu-as \
    --disable-werror )

# keep build quiet so we can see any stderr reports.
if test -f quiet; then
    cat quiet binutils_build/Makefile > Makefile
    mv Makefile binutils_build/Makefile
fi

# note, make.log contains the stderr output of the build.
(cd binutils_build ; make all install 2>&1 ) | tee $BUILDSOURCES/make.log
