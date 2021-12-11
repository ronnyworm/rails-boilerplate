#!/bin/bash

if [ "$1" == "d" ]; then
    docker exec $CONTAINER_NAME ./restart.sh d
else
    docker exec -it $CONTAINER_NAME ./restart.sh
fi

