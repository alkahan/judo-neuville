VOLNAME := $(CURDIR)
include .env
ifeq ($(shell test -f .env.local && echo OK), OK)
include .env.local
endif
