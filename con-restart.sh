#!/bin/bash

source .env

docker exec -it $CONTAINER_NAME ./restart.sh $1
