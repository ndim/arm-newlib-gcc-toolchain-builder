export TARGET="arm-none-eabi"
export PREFIX="$HOME/DevelToolbin/binaries/armThumb-4.7.1"
export PATH="$PREFIX/bin:$PATH"
export BUILDSOURCES="$PWD"

set -e
set -x

setup_builddir() {
    tool_builddir="${1}_build"
    test -n  "$tool_builddir"
    rm -rf   "$tool_builddir"
    mkdir -p "$tool_builddir"
    test -d  "$tool_builddir"
}

# keep build quiet so we can see any stderr reports.
quieten_make() {
    if test -f quiet; then
        cat quiet "$tool_builddir/Makefile" > Makefile.tmp
        mv Makefile.tmp "$tool_builddir/Makefile"
    fi
}
