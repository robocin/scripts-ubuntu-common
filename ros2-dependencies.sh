#!/bin/bash

function is_root {
  [ "${EUID:-$(id -u)}" -eq 0 ];
}

if ! is_root; then
  echo -e "\x1B[31m[ERROR] This script requires root privileges."
  exit 1
fi

if [ -z "$ROS_DISTRO" ]; then
  echo -e "\x1B[31m[ERROR] No ROS distros found."
  exit 1
fi

# Messages
apt install ros-$ROS_DISTRO-geographic-msgs -y