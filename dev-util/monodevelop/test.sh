#!/bin/bash

cd /Z/main/src/core/MonoDevelop.Ide
make  top_distdir=../../../monodevelop-6.1 distdir=../../../monodevelop-6.1/src/core/MonoDevelop.Ide \
     am__remove_distdir=: am__skip_length_check=: am__skip_mode_fix=: distdir
cd -
cat /Z/report.txt
