## What is this for
Create a new application and use the files here to have a good starting point and to dive into development as quickly as possible

## When you see this for the first time
check

- Makefile
- docker-compose.yml
- rails-app/Dockerfile
- rails-app/Gemfile
- rails-app/restart.sh
- example-env
- expected-env-vars.txt

## Steps
- create a new app somewhere
- copy the files from this folder structure there
- change the example-env (ports, names)
- these three files contain the project name in a fresh project (THENAME here)
	- app/views/layouts/application.html.erb:1
	- config/application.rb:1
	- config/initializers/session_store.rb:1
- maybe you need to prepare the collations for the mysql database (make first)

## Run
make start