#!/bin/bash
. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX"; exit 0;
fi
(cd gcc_build && rm -rf * ; \
../gcc_sources/configure -v --quiet --target=$TARGET --prefix=$PREFIX \
   --with-gnu-as --with-gnu-ld --enable-languages=c \
   --enable-interwork --enable-multilib --with-newlib --with-system-zlib \
   --with-headers=${PREFIX}/newlib_sources/newlib/libc/include \
   --disable-werror )
# gcc 4.6.2
# with-system-zlib: Dirty fix "Link tests are not allowed after GCC_NO_EXECUTABLES"
# link to the system installed copy of the Zlib library rather than gccs internal version
# need compile w/wo shared libs??

# keep build quiet so we can see any stderr reports.
cat quiet gcc_build/Makefile > $BUILDSOURCES/Makefile
mv $BUILDSOURCES/Makefile gcc_build/Makefile
# note, make.log contains the stderr output of the build.
(cd gcc_build ; make all install 2>&1 | tee $BUILDSOURCES/make.log)
