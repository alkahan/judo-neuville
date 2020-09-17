REGISTRY_URL ?= registry.ascalium.com
DOCKER_IMAGE_URL ?= $(REGISTRY_URL)/$(PROJECT_NAME)
DOCKERFILE ?= Dockerfile

.PHONY: build
## @docker construit l'image docker
build:
	docker pull $(DOCKER_IMAGE_URL) || true
	docker build \
		-f support/docker/$(DOCKERFILE) \
		--cache-from $(DOCKER_IMAGE_URL) \
		-t $(DOCKER_IMAGE_URL) .


.PHONY: push
## @docker envoie l'image sur le registre
push:
	docker push $(DOCKER_IMAGE_URL)

