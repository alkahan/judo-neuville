DOCKER_SYNC=docker-sync
DOCKER_SYNC_ENV_FILE=../../.env
DOCKER_COMPOSE := $(DOCKER_COMPOSE) -f support/docker/docker-compose.override.yml
VOLNAME = docker-sync-ascalium-${PROJECT_NAME}-data-volume

sync-start: support/docker/.docker-sync support/docker/docker-compose.override.yml

sync-clean:
	@if [ -d 'support/docker/.docker-sync' ]; \
		then \
			cd support/docker; DOCKER_SYNC_ENV_FILE=${DOCKER_SYNC_ENV_FILE} USER_ID=$(USER_ID) $(DOCKER_SYNC) clean; \
	fi

support/docker/docker-compose.override.yml:
	cp support/docker/docker-compose.override.yml.dist support/docker/docker-compose.override.yml

support/docker/.docker-sync: support/docker/docker-sync.yml
	cd support/docker; DOCKER_SYNC_ENV_FILE=${DOCKER_SYNC_ENV_FILE} USER_ID=$(USER_ID) $(DOCKER_SYNC) start;

support/docker/docker-sync.yml:
	cp support/docker/docker-sync.yml.dist support/docker/docker-sync.yml


