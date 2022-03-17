#!/bin/bash

source .env


source=$GENERIC_SCRIPT_SOURCE
paths=(rails-app/restart.sh)
tmp_file=_comp_tmp

for single_path in "${paths[@]}"
do
	local=$(md5 $single_path | cut -d = -f2)

	curl $GENERIC_SCRIPT_SOURCE$single_path > $tmp_file
	remote=$(md5 $tmpfile | cut -d = -f2)

    if [ "$local" != "$remote" ]; then
    	echo $single_path changed - pulling from remote
    	cp $tmp_file $single_path
    else
    	echo $single_path ok
    fi
done

rm $tmp_file