#!/bin/bash

DISTDIR=/var/calculate/remote/distfiles

WORKDIR=/var/tmp/tarballs/dotnet/dev-lang/fsharp

if [ ! -d "$DIRECTORY" ]; then
    mkdir -p "${WORKDIR}"
    git clone https://github.com/fsharp/fsharp.git "${WORKDIR}"
fi
cd "${WORKDIR}"
git reset --hard b005795804fb6dc92a5a319684feb363e5500428
./autogen.sh
make dist
cp "${WORKDIR}/fsharp-201011.tar.bz2" "${DISTDIR}/fsharp-4.0.0_p2016041905.tar.bz2"
cd -
