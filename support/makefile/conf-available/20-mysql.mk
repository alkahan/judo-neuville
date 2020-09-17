
.PHONY: mycli
## @mysql lance mycli sur la base mysql
mycli:
	mycli-docker -p support/docker/secrets/mysql_root_password.txt $(PROJECT_NAME)_sql_1

.PHONY: db-save
## @mysql [nom] fait une sauvegarde de la base de données nommée <nom>
db-save:
	@$(DOCKER_COMPOSE) exec \
	--user $(USER_ID) \
	database \
	    bash -c 'mysqldump -u $$MYSQL_USER -p$$(cat $$MYSQL_PASSWORD_FILE) $$MYSQL_DATABASE > /var/lib/dumps/$$MYSQL_DATABASE.$(args).sql '

.PHONY: db-restore
## @mysql [nom] restaure la dernière sauvegarde nommée <nom>
db-restore:
	@$(DOCKER_COMPOSE) exec \
	--user $(USER_ID) \
	database \
	    bash -c 'cat /var/lib/dumps/$$MYSQL_DATABASE.$(args).sql | mysql -u $$MYSQL_USER -p$$(cat $$MYSQL_PASSWORD_FILE) $$MYSQL_DATABASE'


.PHONY: mysql-secrets
mysql-secrets: support/docker/secrets/mysql_root_password.txt support/docker/secrets/mysql_user_password.txt


support/docker/secrets/mysql_root_password.txt: support/docker/secrets
	openssl rand -out $@ -base64 32

support/docker/secrets/mysql_user_password.txt: support/docker/secrets
	openssl rand -out $@ -base64 32
