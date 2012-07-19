arm-newlib-gcc-toolchain-builder
================================

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


Usage
-----

  * Edit `environ.sh` to adapt to your local requirements, especially
    the `$PREFIX_REAL` where to install the toolchain.

  * Run `sh downloads.txt` to download the source tarballs.

  * Run `make` to run all build step scripts `[0-9]*.sh` in sequence,
    or manually run them in sequence.

  * Run `make clean' to clean up all build and source directories, and
    `$PREFIX_BOOT'.



How this works
--------------

This works with two directories:

   `$BUILDSOURCES'  Source code, build directories, bootstrap install.
   `$PREFIX_REAL'   Where the real toolchain will be installed.

The bootstrap installation of binutils and gccis located in a
subdirectory of `$BUILDSOURCES'.

The toolchain build works in the following stages:

   1. Build and install a bootstrap version of binutils and gcc.
   2. Build and install newlib using the bootstrap binutils/gcc.
   3. Build and install the real binutils, gcc, and gdb.

How exactly the bootstrap and real builds differ is unclear, but the
bootstrap stage has been proven in many test to be necessary for a
working toolchain to be built eventually.


The bootstrap stage
~~~~~~~~~~~~~~~~~~~

TBD: How we build bootstrap binutils/gcc and why. configure options. etc.


newlib
~~~~~~

TBD: How we build newlib and why. configure options. etc.


The real toolchain
~~~~~~~~~~~~~~~~~~

TBD: How we build the real toolchain and why. configure options. etc.



TODO
----

  * Sort configure options for bootgcc and gcc and compare
    differences.

  * Determine what the t-arm-elf interworking stuff is about.

  * Determine what goes differently when installing bootgcc into the
    same place as gcc proper from installing them into different
    places.

  * Document the big picture and the mid-level whys.
