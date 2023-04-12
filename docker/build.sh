#!/usr/bin/env bash

if [[ "$(docker inspect --type=image cuda:11.7.0-base-ubuntu20.04 2> /dev/null)" == "" ]]; then
  echo "You need to build the base cuda image first"
  exit 0
fi

MAIN_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd/.. )

DOCKER_OPTIONS=""
DOCKER_OPTIONS+="-f $MAIN_DIR/docker/nerf-slam.Dockerfile -t nerf-slam:cuda11.7-ubuntu20.04 "
DOCKER_OPTIONS+="--build-arg USER_NAME=$(whoami)"

DOCKER_CMD="docker build $DOCKER_OPTIONS $MAIN_DIR"
echo $DOCKER_CMD
exec $DOCKER_CMD
