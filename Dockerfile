# Base image
FROM ros:humble-ros-base

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    ros-humble-image-transport \
    ros-humble-compressed-image-transport \
    ros-humble-diagnostic-updater \
 && rm -rf /var/lib/apt/lists/*

 # Install ROS Humble RealSense packages (Option 2)
RUN apt-get update && apt-get install -y \
    ros-humble-librealsense2 \
    ros-humble-realsense2-camera \
    && rm -rf /var/lib/apt/lists/*

# Create ROS2 workspace
WORKDIR /ros2_ws_realsense/src

# Clone the ROS2 RealSense wrapper
RUN git clone -b ros2-master https://github.com/IntelRealSense/realsense-ros.git

# Go back to workspace root
WORKDIR /ros2_ws_realsense

# Install ROS2 dependencies (skip librealsense2 since SDK is not installed)
RUN apt-get update && apt-get install -y python3-rosdep \
 && rosdep init || true \
 && rosdep update \
 && rosdep install -i --from-path src --rosdistro humble --skip-keys=librealsense2 -y

# Build the workspace
RUN . /opt/ros/humble/setup.sh && colcon build

# Source ROS2 and workspace on container start
SHELL ["/bin/bash", "-c"]
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN echo "source /ros2_ws_realsense/install/setup.bash" >> ~/.bashrc