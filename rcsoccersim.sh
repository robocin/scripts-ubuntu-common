#!/bin/bash

function is_root {
  [ "${EUID:-$(id -u)}" -eq 0 ];
}

if ! is_root; then
  echo -e "\x1B[31m[ERROR] This script requires root privileges."
  exit 1
fi

GITHUB_RCSOCCERSIM_PREFIX="https://github.com/rcsoccersim"

function install_packages {
  local package_name="$1"
  local base_dir=`pwd`
  local git_url="$GITHUB_RCSOCCERSIM_PREFIX/$package_name.git"

  git clone $git_url
  cd $package_name
  ./bootstrap && ./configure && make -j"$(nproc)" && make install
  mv $package_name /opt
}

if [ "$#" -eq 0 ]; then
  echo -e "\x1B[31m[ERROR] No arguments provided"
  exit 1
fi

for arg in "$@"; do
  install_packages $(echo "$arg")
  if [ $? -ne 0 ]; then
      echo -e "\x1B[31m[ERROR] failed installing $package_name module"
      exit 1
  fi
  cd ..
done