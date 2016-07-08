DISTFILES:=$(shell cat DISTFILES.txt)
MKDIR_P:=mkdir -p

srcdirstrip := $(shell echo "$(srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g')
topsrcdirstrip := $(shell echo "$(top_srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g')

define EOL
$(eval)
$(eval)
endef

define DISTDIR_PROCESS_IN_GROUPS
$(eval _args:=)
$(foreach obj,$1,$(eval _args+=$(obj))$(if $(word $2,$(_args)),$(call $3,$(_args))$(EOL)$(eval _args:=)))
$(if $(_args),$(call $3,$(_args)))
endef

########################################################################################################
# compute list of files and list of directories
# echo and bash for are necessary to add EOL characters after each element before processing by sed

define DISTDIR_REPLACEMENTS_CMD
	for file in $1; do echo $$file; done | \
	   sed -e "s|^${srcdirstrip}/||;t" \
	       -e "s|^${topsrcdirstrip}/|${top_builddir}/|;t";
endef
DISTDIR_REPLACEMENTS=$(shell $(DISTDIR_REPLACEMENTS_CMD))

EDITED_DISTFILES:=$(sort $(subst ${EOL}, ,$(call DISTDIR_PROCESS_IN_GROUPS,${DISTFILES},10,DISTDIR_REPLACEMENTS)))

define DISTDIR_PROCESSDIRS_CMD
	for file in $1; do case "$$file" in \
	  */*) echo $$file | sed '/\//!d;s|^|$(distdir)/|;s,/[^/]*$$,,' ;; \
	esac; \
	done
endef
DISTDIR_PROCESSDIRS=$(shell ${DISTDIR_PROCESSDIRS_CMD})

DISTDIR_DIRECTORY_LIST:=$(sort $(subst ${EOL}, ,$(call DISTDIR_PROCESS_IN_GROUPS,${EDITED_DISTFILES},10,DISTDIR_PROCESSDIRS)))

########################################################################################################
# create directories

define DISTDIR_MKDIR_CMD
	$(MKDIR_P) $1
endef
DISTDIR_MKDIR=$(shell ${DISTDIR_MKDIR_CMD})

########################################################################################################
# copy files

define DISTDIR_COPYING_CMD
	for file in $1; do \
	  if test -f $$file || test -d $$file; then d=.; else d=$(srcdir); fi; \
	  if test -d $$d/$$file; then \
	    dir=`echo "/$$file" | sed -e 's,/[^/]*$$,,'`; \
	    if test -d "$(distdir)/$$file"; then \
	      find "$(distdir)/$$file" -type d ! -perm -700 -exec chmod u+rwx {} \;; \
	    fi; \
	    if test -d $(srcdir)/$$file && test $$d != $(srcdir); then \
	      cp -fpR $(srcdir)/$$file "$(distdir)$$dir" || exit 1; \
	      find "$(distdir)/$$file" -type d ! -perm -700 -exec chmod u+rwx {} \;; \
	    fi; \
	    cp -fpR $$d/$$file "$(distdir)$$dir" || exit 1; \
	  else \
	    test -f "$(distdir)/$$file" \
	    || cp -p $$d/$$file "$(distdir)/$$file" \
	    || exit 1; \
	  fi; \
	done
endef
DISTDIR_COPYING=$(shell ${DISTDIR_COPYING_CMD})

.PHONY: default_target

default_target:
	$(call DISTDIR_PROCESS_IN_GROUPS,${DISTDIR_DIRECTORY_LIST},10,DISTDIR_MKDIR)
	$(call DISTDIR_PROCESS_IN_GROUPS,${EDITED_DISTFILES},10,DISTDIR_COPYING)
	@# this silent empty line mutes "nothing to be done" warning