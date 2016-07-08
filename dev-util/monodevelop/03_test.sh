#!/bin/bash

cd /Z/main/src/core/MonoDevelop.Ide
make  srcdir=. to_srcdir=../../.. top_distdir=../../../monodevelop-6.1 distdir=../../../monodevelop-6.1/src/core/MonoDevelop.Ide \
     am__remove_distdir=: am__skip_length_check=: am__skip_mode_fix=: distdir   # >>/var/lib/tarball-scripts/ArsenShnurkov/shnurise-tarballs-automation/dev-util/monodevelop/res.txt 2>&1
cd -
