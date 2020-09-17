## @mysql [nom] fait une sauvegarde de la base de données nommée <nom>
db-save:
	@$(DOCKER_COMPOSE) exec \
	--user $(USER_ID) \
	database \
	    bash -c 'mysqldump -u $$MYSQL_USER -p$$(cat $$MYSQL_PASSWORD_FILE) $$MYSQL_DATABASE > /var/lib/dumps/$$MYSQL_DATABASE.$(args).sql '

## @mysql [nom] restaure la dernière sauvegarde nommée <nom>
db-restore:
	@$(DOCKER_COMPOSE) exec \
	--user $(USER_ID) \
	database \
	    bash -c 'cat /var/lib/dumps/$$MYSQL_DATABASE.$(args).sql | mysql -u $$MYSQL_USER -p$$(cat $$MYSQL_PASSWORD_FILE) $$MYSQL_DATABASE'
