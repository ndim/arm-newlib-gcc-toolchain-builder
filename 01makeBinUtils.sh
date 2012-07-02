#!/bin/bash
. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX"; exit 0;
fi
export PATH=$PATH:$PREFIX/$TARGET
(cd binutils_build ; \
../binutils_sources/configure -v --quiet  --target=$TARGET --prefix=$PREFIX \
    --enable-interwork --enable-multilib --with-gnu-ld --with-gnu-as \
    --disable-werror )
# keep build quiet so we can see any stderr reports.
cat quiet binutils_build/Makefile > Makefile
mv Makefile binutils_build/Makefile
# note, make.log contains the stderr output of the build.
(cd binutils_build ; make all install 2>&1 | tee $BUILDSOURCES/make.log)

