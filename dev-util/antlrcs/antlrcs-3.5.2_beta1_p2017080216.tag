#!/bin/bash

source ./environment.settings

cd /usr/src/git/github.com/shnurise-tarballs/ArsenShnurkov
pwd

TAGNAME="${CATEGORY}/${PN}${APPENDIX}"
echo "\${TAGNAME}=${TAGNAME}"

git checkout --orphan tmp
rm -rf *
git rm -r --cached *
git rm -r *
cp "${REPACKED_PATHNAME}" .
git add "${PN}${APPENDIX}.tar.gz" || exit
git commit -m "/usr/portage/distfiles/${PN}${APPENDIX}.tar.gz" || exit
git tag -d "${TAGNAME}"
git push origin ":refs/tags/${TAGNAME}"
git tag "${TAGNAME}"
git push origin "${TAGNAME}"
git checkout master
git branch -D tmp

cd "${EBUILD_DIR}"
