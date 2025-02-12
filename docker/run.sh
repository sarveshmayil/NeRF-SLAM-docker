#!/usr/bin/env bash
IMAGE_TAG=nerf-slam:cuda11.7-ubuntu20.04
CONTAINER_NAME=nerf-slam_docker

capabilities_str=\""capabilities=compute,utility,graphics,display\""

xhost local:root

DOCKER_OPTIONS=""
DOCKER_OPTIONS+="-it "
DOCKER_OPTIONS+="-e DISPLAY=$DISPLAY "
DOCKER_OPTIONS+="-v /tmp/.X11-unix:/tmp/.X11-unix "
DOCKER_OPTIONS+="-v $HOME/.Xauthority:/home/$(whoami)/.Xauthority "
# DOCKER_OPTIONS+="-v /home/$USER/:/home/$(whoami)/ "
DOCKER_OPTIONS+="--name $CONTAINER_NAME "
DOCKER_OPTIONS+="--privileged "
DOCKER_OPTIONS+="--gpus=all "
DOCKER_OPTIONS+="-e NVIDIA_DRIVER_CAPABILITIES=video,compute,utility "
DOCKER_OPTIONS+="--net=host "
DOCKER_OPTIONS+="--runtime=nvidia "
DOCKER_OPTIONS+="-e SDL_VIDEODRIVER=x11 "
DOCKER_OPTIONS+="-v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro "
DOCKER_OPTIONS+="-u $(id -u) "
DOCKER_OPTIONS+="--shm-size 32G "
DOCKER_OPTIONS+="$(id --groups | sed 's/\(\b\w\)/--group-add \1/g') "

for cam in /dev/video*; do
  DOCKER_OPTIONS+="--device=${cam} "
done

if [ ${1:-""} == "restart" ]; then 
  echo "Restarting Container"
  docker rm -f $CONTAINER_NAME
  docker run $DOCKER_OPTIONS $IMAGE_TAG /bin/bash
# https://stackoverflow.com/questions/38576337/how-to-execute-a-bash-command-only-if-a-docker-container-with-a-given-name-does
elif [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then # If container isn't running
    
    # If it exists, but needs to be started
    if [  "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then

          echo "Resuming Container"
          docker start $CONTAINER_NAME
          docker exec -it $CONTAINER_NAME /bin/bash
    else
      echo "Running Container"
      docker run $DOCKER_OPTIONS $IMAGE_TAG
    fi
else
  echo "Attaching to existing container"
  docker exec -it $CONTAINER_NAME /bin/bash
fi
