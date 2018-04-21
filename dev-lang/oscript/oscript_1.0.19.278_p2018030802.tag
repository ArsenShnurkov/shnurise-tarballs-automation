#!/bin/bash

CATEGORY="dev-lang"
PN="oscript"
PV="1.0.19.278_p2018030802"
EGIT_ACCOUNT=EvilBeaver
EGIT_REPOSITORY=OneScript

SLOT="0"

EBUILD_DIR="${PWD}"

WORKDIR="/var/tmp/tarballs/shnurise/${CATEGORY}/${PN}"
DISTDIR="${WORKDIR}/distdir"

ARCHIVE_FILE="${WORKDIR}/${PN}-${PV}.tar.gz"
echo "\${ARCHIVE_FILE}=${ARCHIVE_FILE}"

APPENDIX=""
if [ "${SLOT}" != "0" ] ; then
    APPENDIX="-${SLOT}"
fi

TAGNAME="${CATEGORY}/${PN}${APPENDIX}"
echo "\${TAGNAME}=${TAGNAME}"

cd /usr/src/git/github.com/shnurise-tarballs/ArsenShnurkov

git checkout --orphan tmp
rm -rf *
git rm -r --cached *
git rm -r *
cp "${ARCHIVE_FILE}" .
git add *
git commit -m "/usr/portage/distfiles/${PN}-${PV}.tar.gz"
git tag -d "${TAGNAME}"
git push origin ":refs/tags/${TAGNAME}"
git tag "${TAGNAME}"
git push origin "${TAGNAME}"
git checkout master
git branch -D tmp

cd "${EBUILD_DIR}"
