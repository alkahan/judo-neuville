args = $(filter-out $@,$(MAKECMDGOALS))

## List all available commands
HELP_TARGET_MAX_CHAR_NUM = 20

help:
	@awk '/^[a-zA-Z\-\_0-9]+:/ \
		{ \
			helpMessage = match(lastLine, /^## (.*)/); \
			if (helpMessage) { \
				helpCommand = substr($$1, 0, index($$1, ":")-1); \
				helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
				helpGroup = match(helpMessage, /^@([^ ]*)/); \
				if (helpGroup) { \
					helpGroup = substr(helpMessage, RSTART + 1, index(helpMessage, " ")-2); \
					helpMessage = substr(helpMessage, index(helpMessage, " ")+1); \
				} \
				printf "%s|  \033[32m%-$(HELP_TARGET_MAX_CHAR_NUM)s\033[0m %s\n", \
					helpGroup, helpCommand, helpMessage; \
			} \
		} \
		{ lastLine = $$0 }' \
		$(MAKEFILE_LIST) \
	| sort -t'|' -sk1,1 \
	| awk -F '|' ' \
			{ \
			cat = $$1; \
			if (cat != lastCat || lastCat == "") { \
				if ( cat == "0" ) { \
					print "Targets:" \
				} else { \
					gsub("_", " ", cat); \
					printf "Targets %s:\n", cat; \
				} \
			} \
			print $$2 \
		} \
		{ lastCat = $$1 }'

## List all available commands
.help:
	@printf "\n"
	@printf "\033[90;44m\033[1m                   \033[0m\n"
	@printf "\033[90;44m\033[1m Ascalium Makefile \033[0m\n"
	@printf "\033[90;44m\033[1m                   \033[0m\n"
	@printf "\n"
	@printf "\033[33mUsage:\033[0m\n"
	@printf " make [target] [c=\"args|command|query\"]\n\n"
	@printf "\033[33mAvailable targets:\033[0m\n"
	@printf "\n"
	@awk '/^[a-zA-Z\-\_0-9\@]+:/ { \
		helpLine = match(lastLine, /^## (.*)/); \
		helpCommand = substr($$1, 0, index($$1, ":")); \
		helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
		printf " \033[32m%-20s\033[0m %s\n", helpCommand, helpMessage; \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@printf "\n"

.PHONY: help

.DEFAULT_GOAL := help
