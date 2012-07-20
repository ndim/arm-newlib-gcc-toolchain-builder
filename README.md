# arm-newlib-gcc-toolchain-builder

This collection of scripts builds a gcc/newlib based toolchain for
bare metal programming of ARM based CPUs and MCUs.

Specifically, these scripts build

  * [GNU binutils][binutils]
  * [newlib][newlib]
  * [GCC][gcc] (for the C language, C++ to come)
  * [gdb][gdb]


[binutils]:  http://sources.redhat.com/binutils/
             "GNU binutils"
[gcc]:       http://gcc.gnu.org/
             "GNU Compiler Collection"
[gdb]:       http://gnu.org/software/gdb/
             "GNU debugger"
[newlib]:    http://sourceware.org/newlib/
             "newlib C library"


## Usage

  * Edit `environ.sh` to adapt to your local requirements, especially
    the `$PREFIX_REAL` where to install the toolchain.

  * Run `sh downloads.txt` to download the source tarballs.

  * Run `make` to run all build step scripts `[0-9]*.sh` in sequence,
    or manually run them in sequence.

  * Run `make clean` to clean up all build and source directories, and
    `$PREFIX_BOOT`.



## How this works

This works with two directories:

  * `$BUILDSOURCES` Source code, build directories, bootstrap install.
  * `$PREFIX_REAL`  Where the real toolchain will be installed.

The bootstrap installation of binutils and gcc is located in a
subdirectory of `$BUILDSOURCES`.

The toolchain build works in the following stages:

   1. Build and install a bootstrap version of binutils and gcc.
   2. Build and install newlib using the bootstrap binutils/gcc.
   3. Build and install the real binutils, gcc, and gdb.

How exactly the bootstrap and real builds differ is unclear, but the
bootstrap stage has been proven in many test to be necessary for a
working toolchain to be built eventually.



### The bootstrap stage

very simple. just build a "light edition" toolchain (without any libc)
in order to cross compile a working arm-libc. configuration should be
noncritical. if you already have a working arm toolchain you can skip this step.



### Newlib configure switches

_--enable-multilib:_

>compile libraries multiple times for different build
options (e.g. thumb). you may check also `arm-none-eabi-gcc -print-multi-lib`
to see what multilibs gcc uses

_--with-gnu-ld:_

>buildsystem assumes that the GNU linker is being used

_--with-gnu-as:_

>buildsystem assumes that the GNU assembler is being used

_--disable-werror:_

>do not cancel the build on warnings

_--disable-newlib-io-float:_

>disable printf/scanf family float support (status: tbd)

_--disable-newlib-supplied-syscalls:_

>syscalls to the operating system must be served by user code.
it is the users responsibility to implement customized syscall stubs.
newlib shall not provide any syscall implementation because a syscall
is strongly hardware dependant

__Note 1:__ the often mentioned arm/tumb switch `--enable-interwork` is neither
documented nor available in the configure scripts and is therefore removed (20-Jul-2012 samplemaker)

__Note 2:__ for targets `#if __ARM_ARCH__ < 5` like ARM7TDMI (non-FPU) newlib
will emulate float in ieee754-sf.S



### Binutils and GCC configure switches

_--enable-multilib:_

>compile libraries multiple times for different build
options (e.g. thumb). you may check also `arm-none-eabi-gcc -print-multi-lib`
to see what multilibs gcc uses

_--with-gnu-ld:_

>buildsystem assumes that the GNU linker is being used

_--with-gnu-as:_

>buildsystem assumes that the GNU assembler is being used

_--disable-werror:_

>do not cancel the build on warnings

_--enable-languages=c:_

>enable language support for c (cross gcc)

_--with-newlib:_

>specifies that newlib is being used as the target C library. for further
reading you may check:  
[This link](http://gcc.gnu.org/install/configure.html)

_--with-system-zlib:_

>if we build gcc & newlib for bare metal targets we do not have any linker
file nor any crtxx.o. therefore we must avoid some buildsystem configure
scripts trying to do a link test. up to now there is no direct solution for
that circumstance. as a workaround we link to the system installed copy of
the Zlib library rather than gccs internal version. for further reading you
may check:   
[This link](http://gcc.gnu.org/ml/gcc/2008-03/msg00515.html)

_--with-headers="${PREFIX_REAL}/newlib_sources/newlib/libc/include":_

>directory which holds the target #include files (obligatory). for further
reading you may check:  
[This link](http://gcc.gnu.org/install/configure.html)


__Note 1:__ the often mentioned arm/tumb switch `--enable-interwork` is neither
documented nor available in the configure scripts and is therefore removed (20-Jul-2012 samplemaker)   
See: [This link](http://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html) and [This link](http://gcc.gnu.org/install/configure.html)   



## TODO

  * Sort configure options for bootgcc and gcc and compare
    differences.

  * Determine what the t-arm-elf interworking stuff is about.

  * Determine what goes differently when installing bootgcc into the
    same place as gcc proper from installing them into different
    places.

  * Document the big picture and the mid-level whys.
