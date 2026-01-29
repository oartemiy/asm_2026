#!/bin/bash

die()
{
    if [ $# -gt 0 ]; then
        echo >&2 "$*"
    fi
    exit 1
}


if [ $# -ne 1 ]; then
    die "Usage: $0 <asm-file-name>"
fi

prog_s=$1
basename=${prog_s%.*}

if [ "$basename" = "$prog_s" ]; then
    die "You must use file extension!"
fi

osname=$(uname -s) || die
nasm_opts=(-g)
case $(echo "$osname" | tr '[:upper:]' '[:lower:]') in
    *cygwin*)
        systype=CYGWIN
        objformat=win32
        nasm_opts+=(--prefix _)
        ;;
    *linux*|*freebsd*)
        systype=UNIX
        objformat=elf32
        ;;
    *darwin*)
        systype=DARWIN
        objformat=macho32
        nasm_opts+=(--prefix _)
        ;;
    *)
        die "Usupported OS '$osname'"
        ;;
esac
nasm_opts+=(-f "$objformat" "-D$systype")

macro_o=/tmp/_asm_build_$$.o
prog_o=${basename}.o
trap 'rm -f $macro_o $prog_o' EXIT

bundle=$(cd "$(dirname "$0")" && pwd -P) || die
nasm_opts+=(-I "$bundle")
gcc -c -g -Wfatal-errors -fno-pie -m32 -o "$macro_o" "${bundle}/macro.c" || die
nasm "${nasm_opts[@]}" -o "$prog_o" "$prog_s" || die
gcc -no-pie -m32 -o "$basename" "$prog_o" "$macro_o" || die
