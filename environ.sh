export TARGET="arm-none-eabi"
export PREFIX_REAL="$HOME/DevelToolbin/binaries/armThumb-4.7.1"
export PREFIX_BOOT="$HOME/DevelToolbin/trash_bootgcc"
export PATH="$PREFIX_REAL/bin:$PATH"
export BUILDSOURCES="$PWD"

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
}

# keep build quiet so we can see any stderr reports.
quieten_make() {
    if test -f quiet; then
        cat quiet "$tool_builddir/Makefile" > Makefile.tmp
        mv Makefile.tmp "$tool_builddir/Makefile"
    fi
}

# Run configure
run_configure() {
    cd "$tool_builddir" && "../${tool_srcdir}/configure" "$@"
}

# Run make
run_make() {
    make ${MAKE_FLAGS} -C "$tool_builddir" "$@" 2>&1 | log_output
}

# Log stdin to somewhere
log_output() {
    tee "$BUILDSOURCES/make.log"
}
