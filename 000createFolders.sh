#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX_REAL" == "" || "$PREFIX_BOOT" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX_REAL and PREFIX_BOOT in ./environ.sh !"; exit 0;
fi

sources="binutils-2.22 gcc-4.7.3 gdb-7.6 newlib-1.20.0"

# check for sources before we go on.
for src in $sources; do
	if [ ! -f downloads/$src.tar.bz2 ]; then
		if [ ! -f downloads/$src.tar.gz ]; then
			echo "missing source for: $src" ;
			return;
		fi
	fi
done


# inflate sources
for src in $sources ; do
	DIR=`echo $src | sed 's/-.*//'`_sources;
	echo -n "check existance of directory: $DIR ($src) - " ;
	if [ ! -d $DIR ] ; then
		echo "NO ... inflating from downloads"
		if [ -f downloads/$src.tar.bz2 ]; then
			tar -jxf downloads/$src.tar.bz2 ;
		fi
		if [ -f downloads/$src.tar.gz ]; then
			tar -zxf downloads/$src.tar.gz ;
		fi
		echo "rename directory $src into $DIR"
		mv $src $DIR ;
	else
		echo "OK" ;
	fi
done

