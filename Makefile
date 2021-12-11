include .env
export $(shell sed 's/=.*//' .env)

first:
	@echo "Open phpMyAdmin in the browser and execute this for all environments (_dev, _test, _prod)"
	@echo "drop database xyz_dev; -- because the collation will be wrong otherwise"
	@echo "CREATE DATABASE xyz_dev CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
	@echo "GRANT ALL ON xyz_dev.* TO 'username';"
	@echo ""
	@echo "Also do this:"
	cat rails-app/db/starting-data.sql

start:
	docker-compose --project-name $(PROJECT_NAME) up -d
	./con-restart.sh

startd:
	docker-compose --project-name $(PROJECT_NAME) up -d
	./con-restart.sh d
	
intocon:
	docker exec -it $(shell docker ps | grep $(CONTAINER_NAME) | cut -d \  -f1) /bin/bash

stop:
	docker-compose stop

test:
	docker exec -it $(CONTAINER_NAME) rake test RAILS_ENV=test

assets:
	docker exec -it $(CONTAINER_NAME) rake assets:precompile

publish:
	ssh ronny@anhupen.de -t 'cd /home/ronny/$(PROJECT_NAME) && git pull && make startd && exit; bash -l'

ngrok:
	ngrok http $(RAILS_PORT)

# vim: set autoindent noexpandtab tabstop=4 shiftwidth=4
