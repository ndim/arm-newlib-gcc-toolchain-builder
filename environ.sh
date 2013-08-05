export TARGET="arm-none-eabi"
export BUILDSOURCES="$PWD"
export PREFIX_BOOT="$BUILDSOURCES/trash_bootgcc_prefix"
export PREFIX_REAL="$HOME/DevelToolbin/binaries/armThumb-4.7.3"
export PATH="$PREFIX_REAL/bin:$PATH"

set -e
set -x

setup_dirs() {
    tool_builddir="${1}_build"
    test -n  "$tool_builddir"
    rm -rf   "$tool_builddir"
    mkdir -p "$tool_builddir"
    test -d  "$tool_builddir"
    if test "x$2" = "x"; then
	tool_srcdir="${1}_sources"
    else
	tool_srcdir="${2}_sources"
    fi
    test -n  "$tool_srcdir"
    test -d  "$tool_srcdir"

    rm -f "$BUILDSOURCES/$(basename "$0" .sh)".*.log
}

# Run configure
run_configure() {
    pushd "$tool_builddir"
    "../${tool_srcdir}/configure" --disable-nls -v "$@" 2>&1 | log_output configure
    popd
}

# Run make
run_make() {
    cflags=""
    cflags="$cflags -O2 -g"
    cflags="$cflags -pipe"
    cflags="$cflags -Wall"
    cflags="$cflags -Wp,-D_FORTIFY_SOURCE=2"
    cflags="$cflags -fexceptions"
    cflags="$cflags -fstack-protector --param=ssp-buffer-size=4"
    cflags="$cflags "
    make ${MAKE_FLAGS} -C "$tool_builddir" CFLAGS="$cflags" "$@" 2>&1 | log_output make
}

# Log stdin to somewhere
log_output() {
    tee "$BUILDSOURCES/$(basename "$0" .sh).${1-undefined}.log"
}
