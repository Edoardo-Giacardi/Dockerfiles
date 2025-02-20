#!/usr/bin/env bash

# make the file executable: chmod +x docker_run.bash

# ===========================================
# docker_run.bash
# ===========================================
# This script runs the container interactively
# and removes it upon exit, providing some
# typical options like X11 forwarding for GUI.
# =============================

# Immediately exit if any command within the script returns a non-zero exit status
set -e

# Define necessary variables directly in the script
IMAGE="ros2_mipo"    # Docker image name (should match the one built via docker_build.bash)
TAG="latest"                             # Docker image tag
CMD_INTERACTIVE="/bin/bash"           # Command to run in interactive mode
HOSTNAME="localhost"                  # Hostname for the container
USERNAME="ros"                        # User name inside the container
WORKSPACE="ros2_ws"                   # Workspace directory inside the container
CONTAINER_NAME="ros2_mipo_container"  # Name of the container

echo "Running container: $CONTAINER_NAME"

# Allow local docker containers to connect to X server (if not done previously)
xhost +local:docker


# Run docker    
docker run -it --rm \
  --hostname $HOSTNAME \
  --name "${CONTAINER_NAME}" \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --privileged \
  --net=host \
  -w /home/$USERNAME/$WORKSPACE \
  -v /dev:/dev \
  -e DISPLAY=$DISPLAY \
  "${IMAGE}:${TAG}" \
  "$CMD_INTERACTIVE" 
