#!/bin/bash

DISTDIR=/var/calculate/remote/distfiles

# Path to directory, for example: "${PORTDIR}/${CATEGORY}/${PN}/files"
FILESDIR=/var/lib/tarball-scripts/ArsenShnurkov/shnurise-tarballs-automation/dev-util/monodevelop/files

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
patch ${WORKDIR}/main/src/core/MonoDevelop.Ide/Makefile.am ${FILESDIR}/main-src-core-Monodevelop.Ide-Makefile.am.patch
./configure --profile=all
#make dist
#cp "${WORKDIR}/tarballs/monodevelop-6.1.tar.bz2" "${DISTDIR}/monodevelop-6.1_p2016062206.tar.bz2"
#cp "${WORKDIR}/tarballs/monodevelop-database-6.1.tar.bz2" "${DISTDIR}/monodevelop-6.1_p2016062206.tar.bz2"
cd -
