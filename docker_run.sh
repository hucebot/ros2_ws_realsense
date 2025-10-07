#!/bin/bash

# I use --volume /dev:/dev, otherwise I have to pass manually each device
docker run -it --rm \
    --volume /dev:/dev \
    --privileged \
    realsense_ros2
