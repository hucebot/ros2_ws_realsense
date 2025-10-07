#!/bin/bash

xhost +local:root

# I use --volume /dev:/dev, otherwise I have to pass manually each device
docker run -it --rm \
    --volume /dev:/dev \
    --privileged \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    realsense_ros2
