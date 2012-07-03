#!/bin/bash

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX"; exit 0;
fi

(cd gdb_build && rm -rf * ; \
../gdb_sources/configure -v --quiet --prefix=$PREFIX \
   --target=$TARGET --enable-interwork --enable-multilib \
   --with-gnu-ld --with-gnu-as \
	--disable-werror )

# keep build quiet so we can see any stderr reports.
if test -f quiet; then
    cat quiet gdb_build/Makefile > $BUILDSOURCES/Makefile
    mv $BUILDSOURCES/Makefile gdb_build/Makefile
fi

# note, make.log contains the stderr output of the build.
(cd gdb_build ; make all install 2>&1 | tee $BUILDSOURCES/make.log)
