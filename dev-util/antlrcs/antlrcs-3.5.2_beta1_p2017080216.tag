#!/bin/bash

CATEGORY="dev-utils"
PN="antlrcs"
PV="3.5.2_beta1_p2017080216"
EGIT_ACCOUNT=antlr
EGIT_REPOSITORY=antlrcs

SLOT="0"
APPENDIX=""
if [ "${SLOT}" != "0" ] ; then
    APPENDIX="-${SLOT}"
fi

EBUILD_DIR="${PWD}"

WORKDIR="/var/tmp/tarballs/shnurise/${CATEGORY}/${PN}${APPENDIX}"
DISTDIR="${WORKDIR}/distdir"

ARCHIVE_FILE="${WORKDIR}/${PN}${APPENDIX}.tar.gz"
echo "\${ARCHIVE_FILE}=${ARCHIVE_FILE}"

APPENDIX=""
if [ "${SLOT}" != "0" ] ; then
    APPENDIX="-${SLOT}"
fi

TAGNAME="${CATEGORY}/${PN}${APPENDIX}"
echo "\${TAGNAME}=${TAGNAME}"

cd /usr/src/git/github.com/shnurise-tarballs/ArsenShnurkov
pwd

git checkout --orphan tmp
rm -rf *
git rm -r --cached *
git rm -r *
cp "${ARCHIVE_FILE}" .
git add "${PN}${APPENDIX}.tar.gz" || exit
git commit -m "/usr/portage/distfiles/${PN}${APPENDIX}.tar.gz" || exit
git tag -d "${TAGNAME}"
git push origin ":refs/tags/${TAGNAME}"
git tag "${TAGNAME}"
git push origin "${TAGNAME}"
git checkout master
git branch -D tmp

cd "${EBUILD_DIR}"
