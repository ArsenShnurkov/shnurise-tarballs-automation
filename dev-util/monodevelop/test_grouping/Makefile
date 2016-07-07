DISTFILES:=aaa aab aac
#DISTFILES := $(shell sed ':a;N;$!ba;s/\n/ /g' /usr/share/dict/words)

# EOL definition is
# taken from http://stackoverflow.com/questions/12528637/how-do-i-execute-each-command-in-a-list
define EOL


endef

# The max_args function takes three parameters: 
# the base command-line, 
# the number of arguments per “chunk”, and 
# the complete list of arguments.
# taken from https://blog.melski.net/2012/01/03/makefile-hacks-automatically-split-long-command-lines/
define max_args
  $(eval _args:=)
  $(foreach obj,$3,$(eval _args+=$(obj))$(if $(word $2,$(_args)),$1$(_args)$(EOL)$(eval _args:=)))
  $(if $(_args),$1$(_args))
endef

EDITED_DISTFILES:=""

define append_with_progress
EDITED_DISTFILES+=$(shell echo ${1}|sed 's-b-B-g')
endef

$(exec $(call max_args,$(exec $(call append_with_progress,${w})${EOL})),100,$(DISTFILES)))

.PHONY: default_target

define my_macros
@echo ${1}
endef


default_target:
	$(foreach w,$(EDITED_DISTFILES),$(call my_macros,${w})${EOL})
