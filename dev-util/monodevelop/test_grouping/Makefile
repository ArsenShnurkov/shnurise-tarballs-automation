DISTFILES := aaa aab aba abb baa bab bba bbb

TAB:=$(subst Z,$(eval),Z	Z)

define EOL
$(eval)
$(eval)
endef

srcdirstrip=`echo "$(srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g'`
topsrcdirstrip=`echo "$(top_srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g'`;

EDITED_DISTFILES:=

define DISTDIR_REPLACEMENTS
	$(info $1)
	EDITED_DISTFILES+=$(shell for file in $1; do echo $$file; done | \
	  sed -e "s|^$$srcdirstrip/||;t" \
	    -e "s|^$$topsrcdirstrip/|$(top_builddir)/|;t"; )
endef

DISTDIR_REPLACEMENTS_DETABULATED=$(subst ${TAB},,${DISTDIR_REPLACEMENTS})

define split_to_groups
$(eval _args:=)
$(foreach obj,$1,$(eval _args+=$(obj))$(if $(word $2,$(_args)),$(call $3,$(_args))$(EOL)$(eval _args:=)))
$(if $(_args),$(call $3,$(_args)))
endef

.PHONY: default_target

define my_macros
@echo ${1}
endef

$(eval $(call split_to_groups,$(sort ${DISTFILES}),3,DISTDIR_REPLACEMENTS_DETABULATED))

default_target:
	$(info ###$(DISTDIR_REPLACEMENTS_DETABULATED)###)
	$(foreach w,$(sort $(EDITED_DISTFILES)),$(call my_macros,${w})${EOL})
