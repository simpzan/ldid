#!/bin/bash

set -e

sudo xcode-select --switch /Applications/Xcode.app

if which xcrun &>/dev/null; then
    flags=(xcrun -sdk macosx g++)
    flags+=(-mmacosx-version-min=10.9)

    for arch in i386 x86_64; do
        flags+=(-arch "${arch}")
    done
else
    flags=(g++)
fi

flags+=(-I.)

set -x
"${flags[@]}" -c -std=c++11 -o ldid.o ldid2.cpp
"${flags[@]}" -o ldid2 ldid.o -x c lookup2.c -x c sha1.c sha224-256.c
