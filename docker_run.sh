#!/bin/bash

xhost +local:docker

# I use --volume /dev:/dev, otherwise I have to pass manually each device
docker run -it --rm \
    --env DISPLAY=$DISPLAY \
    --env XAUTHORITY=$XAUTHORITY \
    --env XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
    --env QT_X11_NO_MITSHM=1 \
    --env RMW_IMPLEMENTATION=rmw_cyclonedds_cpp \
    --env ROS_DOMAIN_ID=39 \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --net host \
    --ipc host \
    --pid host \
    --volume /dev:/dev \
    --privileged \
    realsense_ros2
