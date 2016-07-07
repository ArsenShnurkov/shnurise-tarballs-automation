#!/bin/bash

DISTDIR=/var/calculate/remote/distfiles

WORKDIR=/var/tmp/tarballs/dotnet/dev-lang/mono
mkdir -p "${WORKDIR}"
git clone https://github.com/mono/mono.git "${WORKDIR}"
cd "${WORKDIR}"
git reset --hard b10c89c9044370b7f5c9638be87d3594ea32fd53
./autogen.sh
make dist
cp "${WORKDIR}/*.tar.bz2" "${DISTDIR}/mono-4.5.2_p2016061606.tar.bz2"
cd -
