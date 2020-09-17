include $(sort $(wildcard support/makefile/conf-enabled/*.mk))


docker-secret: mysql-secrets

## @deploy deploiement
deploy:
	DOCKER_HOST=ssh://root@nas make build
	DOCKER_HOST=ssh://root@nas make push
	GL_REPO_BASE=1 make up

## @deploy mise en prod uniquement
up-prod:
	GL_REPO_BASE=1 make up

## dev serveur de dev
dev:
	hugo --config config.dev.toml serve

## @tools download icons
icons:
	sh support/tools/fontawesome.sh




%:      # thanks to chakrit
#		$(filter-out $@,$(MAKECMDGOALS))
	    @:    # thanks to William Pursell
