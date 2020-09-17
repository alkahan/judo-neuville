# This file should be include after Makefile.docker-compose.mk
#
DOCKER_HOST=
PUBLIC_NETWORK=ascalium
DOCKER_ENV=dev

# Vars in gitolite
ifdef GL_REPO_BASE
DOCKER_HOST=ssh://root@nas
PUBLIC_NETWORK=public
DOCKER_ENV=prod
# Override previous vars in .env.gitolite
ifeq ($(shell test -f .env.gitolite && echo OK), OK)
include .env.gitolite
endif
ifeq ($(shell test -f .env.local.gitolite && echo OK), OK)
include .env.local.gitolite
endif
endif


DOCKER_COMPOSE=DOCKER_HOST=${DOCKER_HOST} docker-compose -p $(PROJECT_NAME) -f support/docker/docker-compose.yml -f support/docker/docker-compose.${DOCKER_ENV}.yml
DOCKER_CMD=DOCKER_HOST=${DOCKER_HOST} docker
