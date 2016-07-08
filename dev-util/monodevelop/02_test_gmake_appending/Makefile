#DISTFILES:=aaa aab aac
DISTFILES := $(shell sed ':a;N;$!ba;s/\n/ /g' /usr/share/dict/words)

# EOL definition is taken from http://stackoverflow.com/questions/12528637/how-do-i-execute-each-command-in-a-list
define EOL


endef

EDITED_DISTFILES:=""

define append_with_progress
EDITED_DISTFILES+=$(shell echo ${1}|sed "s/a/A/g")
endef

$(foreach w,$(DISTFILES),$(exec $(call append_with_progress,${w})${EOL}))

.PHONY: default_target

define my_macros
#@echo ${1}
@echo .
endef


default_target:
	$(foreach w,$(DISTFILES),$(call my_macros,${w})${EOL})
