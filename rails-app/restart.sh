#!/bin/bash

killname(){
    var=$(ps -e | grep $1 | grep -v grep)
    var2=($var)
    if [ ! -z ${var2[0]} ]; then
        kill ${var2[0]}
        echo "killed $1"
    else
        echo "nothing to kill ($1)"
    fi
}
killname ruby
killname ruby

if [ -f tmp/pids/server.pid ]; then
	rm tmp/pids/server.pid
fi

if [ "$1" != "quick" ]; then

	printf "restart.sh for $RAILS_ENV\n\n"

	printf "Checking .env-Variables ... "
	while read line; do
		if [[ ! "$(env)" =~ "$line" ]]; then
			printf "Env-Variable $line missing - set up first!\n\n" && exit 1
		fi
	done <expected-env-vars.txt

	printf "done\nrake assets:precompile ... "
	while [ 1 ]; do
		result=$(RAILS_ENV=$RAILS_ENV rake assets:precompile 2>&1)
        echo $result

        if [[ "$result" =~ "ExecJS::RuntimeUnavailable" ]]; then
            exit
        fi

        if [[ "$result" =~ "Could not find" ]]; then
            bundle install
        else
            if [[ "$result" =~ "Error" ]]; then
                exit
            fi
            break
        fi
	done

	printf "done\nrake test\n"
	rake test RAILS_ENV=test

	printf "rake db:migrate\n"
	RAILS_ENV=$RAILS_ENV rake db:migrate
fi

printf "rails server\n"
if [ "$RAILS_ENV" == "production" ]; then

	while [ 1 ]; do
		result=$(rails server -b 0.0.0.0 -p $RAILS_PORT -e $RAILS_ENV -d 2>&1)

		if [[ "$result" =~ "rails: command not found" ]]; then
			bundle install
		else
			break
		fi
	done

else
    if [ ! -z "$1" ]; then
        rails server -u puma -b 0.0.0.0 -p $RAILS_PORT -e $RAILS_ENV -d
    else
        rails server -u puma -b 0.0.0.0 -p $RAILS_PORT -e $RAILS_ENV
    fi
fi
