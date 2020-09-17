DOCKER_COMPOSE = docker-compose --project-name=$(PROJECT_NAME) -f support/docker/docker-compose.yml
OS_NAME=$(shell uname -s)
USER_ID=$(shell id -u)

ifeq ($(OS_NAME), Darwin)
include support/Makefile.docker-sync.mk
endif

clean: kill down

## @docker-compose arrête les conteneurs
down: sync-clean
	$(DOCKER_COMPOSE) down

kill:
	$(DOCKER_COMPOSE) kill

## @docker-compose Démarrage des conteneurs
up: sync-start
	$(DOCKER_COMPOSE) pull --ignore-pull-failures
	$(DOCKER_COMPOSE) up -d

## @docker-compose Affiche les logs des conteneurs
logs:
	$(DOCKER_COMPOSE) logs --tail=100 -f $(args)

## @docker-compose Liste les conteneurs
ps:
	$(DOCKER_COMPOSE) ps

## @docker-compose commande docker-compose
docker-compose:
	@$(DOCKER_COMPOSE) ${c}

## @docker-compose Execute une commande dans un conteneur
exec:
	$(DOCKER_COMPOSE) exec $(args)

sync-start:
sync-clean:
docker-secret:

support/docker/secrets:
	@mkdir -p $@

