#!/usr/bin/env sh

. ./.env

#export DOCKER_BUILDKIT=1
#export COMPOSE_DOCKER_CLI_BUILD=1

xhost +local:
mkdir -p "${FOLDER_BUILD}"
mkdir -p "${FOLDER_FILES}"

docker-compose down
docker-compose up --build --remove-orphans
