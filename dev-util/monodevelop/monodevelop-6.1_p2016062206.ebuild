#!/bin/bash

DISTDIR=/var/calculate/remote/distfiles

#WORKDIR=/var/tmp/tarballs/dotnet/dev-util/monodevelop
WORKDIR=/Z

echo CHECKPOINT 1

if [ ! -d "${WORKDIR}" ]; then
    mkdir -p "${WORKDIR}"
    cd "${WORKDIR}"
    git clone https://github.com/mono/monodevelop.git "${WORKDIR}"
else
    cd "${WORKDIR}"
    git fetch origin
fi

echo CHECKPOINT 2

git reset --hard 81446f1843f35719f40d766efced30680096a636

echo CHECKPOINT 3

git submodule update --init --recursive

echo CHECKPOINT 4

# cd "${WORKDIR}"
touch extras/MonoDevelop.Database/ChangeLog
./configure --profile=all
make dist
cp "${WORKDIR}/*.tar.bz2" "${DISTDIR}/monodevelop-0.0.0_p2016062206.tar.bz2"
cd -
