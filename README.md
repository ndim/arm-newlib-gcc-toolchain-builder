arm-newlib-gcc-toolchain-builder
================================

This collection of scripts builds a gcc/newlib based toolchain for
bare metal programming of ARM based CPUs and MCUs.

Specifically, these scripts build

  * [GNU binutils][binutils]
  * [newlib][newlib]
  * [GCC][gcc] (for the C language, C++ to come)
  * [gdb][gdb]


Usage
-----

  * Edit `environ.sh` to adapt to your local requirements, especially
    the `PREFIX` where to install the toolchain.

  * Run `sh downloads.txt` to download the source tarballs.

  * Run `make` to run all build step scripts `0*.sh` in sequence,
    or manually run them in sequence.



[binutils]:  http://sources.redhat.com/binutils/
             "GNU binutils"
[gcc]:       http://gcc.gnu.org/
             "GNU Compiler Collection"
[gdb]:       http://gnu.org/software/gdb/
             "GNU debugger"
[newlib]:    http://sourceware.org/newlib/
             "newlib C library"
