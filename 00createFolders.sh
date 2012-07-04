#!/bin/bash

set -e

. ./environ.sh
if [[ "$TARGET" == ""  || "$PREFIX" == "" ]] ; then
	echo "You need to set: TARGET and PREFIX in ./environ.sh !"; exit 0;
fi

sources="binutils-2.22 gcc-4.7.1 gdb-7.4.1"

#newlib is build in a seperate folder therefore it is handled differently
newlib_src="newlib-1.20.0"

newlib_pkg() {
	echo -n "check existance of directory: $PREFIX/newlib_sources ($newlib_src) - " ;
	if [ ! -d $PREFIX/newlib_sources ] ; then
		echo "NO ... inflating from downloads"
		mkdir -p $PREFIX
		tar zxCf $PREFIX downloads/$newlib_src.tar.gz;
		echo "rename directory $PREFIX/$newlib_src into $PREFIX/newlib_sources"
		mv $PREFIX/$newlib_src $PREFIX/newlib_sources;
	else
		echo "OK" ;
	fi
}

# check for sources before we go on.
for src in $sources $newlib_src ; do 
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

# newlib gets done seperately
newlib_pkg;


