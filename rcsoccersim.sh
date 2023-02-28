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
  local tmp_dir="/tmp/${package_name}"
  local git_url="${GITHUB_RCSOCCERSIM_PREFIX}/${package_name}.git"

  rm -rf "${tmp_dir}"
  mkdir -p "${tmp_dir}"

  git clone "${git_url}" -o "${package_name}" "${tmp_dir}"
  pushd "${tmp_dir}" || exit 1
  ./bootstrap && ./configure --prefix "/opt/${package_name}" && make -j"$(nproc)" && make install
  popd || exit 1

  rm -rf "${tmp_dir}"
}

if [ "$#" -eq 0 ]; then
  echo -e "\x1B[31m[ERROR] No arguments provided"
  exit 1
fi

ARGS=${1}
IFS=' ' #set the internal field separator to 
read -ra TOKENS <<< "$ARGS"
for arg in "${TOKENS[@]}"; do
  install_packages $(echo "$arg")
  if [ $? -ne 0 ]; then
      echo -e "\x1B[31m[ERROR] failed installing $package_name module"
      exit 1
  fi
done