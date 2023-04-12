#!/usr/bin/env bash

if [[ "$(docker inspect --type=image 11.3.0-base-ubuntu20.04:latest 2> /dev/null)" == "" ]]; then
  echo "You need to build the base cuda image first"
  exit 0
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DOCKER_OPTIONS=""
DOCKER_OPTIONS+="-f $SCRIPT_DIR/nerf-slam.Dockerfile -t nerf-slam:cuda11.3-ubuntu20.04 "
DOCKER_OPTIONS+="--build-arg USER_NAME=$(whoami)"

DOCKER_CMD="docker build $DOCKER_OPTIONS $SCRIPT_DIR"
echo $DOCKER_CMD
exec $DOCKER_CMD
