DISTFILES := $(shell cat /usr/share/dict/words)

# EOL definition is
# taken from http://stackoverflow.com/questions/12528637/how-do-i-execute-each-command-in-a-list
define EOL


endef

define run_shell_command
NOK+=.
EDITED_DISTFILES+=$(shell echo ${1}| \
 sed 's/./\L&/g'| \
 sed 's-b-B-g')
endef

define split_to_groups
$(eval _args:=)
$(foreach obj,$1,$(eval _args+=$(obj))$(if $(word $2,$(_args)),$(call run_shell_command,$(_args))$(EOL)$(eval _args:=)))
$(if $(_args),$(call run_shell_command,$(_args)))
endef

NOK:=
EDITED_DISTFILES:=
$(eval $(call split_to_groups,${DISTFILES},10000))

.PHONY: default_target

define my_macros
@echo ${1}
endef

default_target:
	# comment
	@echo ${NOK}
	$(foreach w,$(EDITED_DISTFILES),$(call my_macros,${w})${EOL})
