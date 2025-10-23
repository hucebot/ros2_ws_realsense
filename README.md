# Realsense docker

This docker file can be used to setup automatically realsense and make it publish topics on ROS2 Humble.

## 1. Build docker

Digit the following command (in the folder where **Dockerfile** is located) to create the docker image:

```bash
docker build -t realsense_ros2 .
```

## 2. Access container

From the same folder, digit the following command:

```bash
./docker_run.sh
```

## 3. Start realsense

Installation guide for realsense:

https://github.com/IntelRealSense/realsense-ros

To check whether realsense is connected:

```bash
lsusb | grep RealSense
```

Once inside the container, you can start your ROS2 node by launching realsense node:

```bash
ros2 launch realsense2_camera rs_launch.py
```

```bash
ros2 launch realsense2_camera rs_launch.py \
    rgb_camera.color_profile:=640,480,15 \
    depth_module.depth_profile:=640,480,15 \
    enable_depth:=true \
    align_depth.enable:=true
```

Compute pointcloud:

```bash
ros2 launch realsense2_camera rs_launch.py \
    rgb_camera.color_profile:=640,480,15 \
    depth_module.depth_profile:=640,480,15 \
    align_depth.enable:=true \
    pointcloud.enable:=true
 ```

**Note**: To visualize the pointcloud in RViz, select the frame = camera_link.

Important topics:

```bash
ros2 topic hz /camera/camera/aligned_depth_to_color/image_raw
ros2 topic hz /camera/camera/aligned_depth_to_color/image_raw/compressed
```

```bash
ros2 topic hz /camera/camera/color/image_raw
ros2 topic hz /camera/camera/color/image_raw/compressed
```

To visualize:

```bash
ros2 run rqt_image_view rqt_image_view
```

## 4. Additional info

For additional info, make reference to:

https://github.com/hucebot/ros2_ws_webcam

