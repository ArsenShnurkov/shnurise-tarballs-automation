DISTFILES := aaa aab aba abb baa bab bba bbb

empty :=

define EOL
$(empty)
$(empty)
endef

define run_shell_command
EDITED_DISTFILES+=$(shell echo ${1}| \
 sed 's/./\L&/g'| \
 sed 's-b-B-g')
endef

define split_to_groups
$(eval _args:=)
$(foreach obj,$1,$(eval _args+=$(obj))$(if $(word $2,$(_args)),$(call $3,$(_args))$(EOL)$(eval _args:=)))
$(if $(_args),$(call $3,$(_args)))
endef

.PHONY: default_target

define my_macros
@echo ${1}
endef

EDITED_DISTFILES:=
$(eval $(call split_to_groups,$(sort ${DISTFILES}),3,run_shell_command))

default_target:
	$(foreach w,$(sort $(EDITED_DISTFILES)),$(call my_macros,${w})${EOL})
