## @docker bash
terminal:
	@$(DOCKER_COMPOSE) exec \
	--user $(USER_ID) \
	-w /var/www/html \
	${TERMINAL} \
		bash

.PHONY: wp-install
## @wordpress wordpress core install
wp-install:
	@$(DOCKER_COMPOSE) exec \
	--user $(USER_ID) \
	-w /var/www/html \
	cli \
		wp core install \
		--url=${WP_URL} \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--admin_password="${WP_ADMIN_PASSWORD}"


## Construit les images dockers pour la dev
build:
	# Running image
	docker pull nas:5000/wordpress || true
	docker build \
		--build-arg APP_ENV=dev \
		--cache-from nas:5000/wordpress	\
		-t nas:5000/wordpress \
		-f support/docker/Dockerfile .
	docker push nas:5000/wordpress
	# CLI
	docker pull nas:5000/wordpress || true
	docker build \
		--build-arg APP_ENV=dev \
		--cache-from nas:5000/wordpress	\
		--cache-from nas:5000/wordpress:cli	\
		-t nas:5000/wordpress:cli	\
		-f support/docker/Dockerfile.cli .
	docker push nas:5000/wordpress:cli

wp-content dumps:
	@mkdir -p $@
	@chmod 777 $@

var/log:
	@mkdir -p var/log
