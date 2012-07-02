#!/bin/bash
. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX"; exit 0;
fi
export PATH=$PATH:$PREFIX/$TARGET
(cd bootgcc_build ; \
../gcc_sources/configure -v --quiet --target=$TARGET --prefix=$PREFIX \
   --with-newlib --without-headers --with-gnu-as \
   --with-gnu-ld --disable-shared --enable-languages=c \
   --disable-werror )
# keep build quiet so we can see any stderr reports.
cat quiet bootgcc_build/Makefile > Makefile
mv Makefile bootgcc_build/Makefile
# note, make.log contains the stderr output of the build.
(cd bootgcc_build ; make all-gcc install-gcc 2>&1 | tee $BUILDSOURCES/make.log)
