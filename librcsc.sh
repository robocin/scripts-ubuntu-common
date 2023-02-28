#!/bin/bash

function is_root {
  [ "${EUID:-$(id -u)}" -eq 0 ];
}

if ! is_root; then
  echo -e "\x1B[31m[ERROR] This script requires root privileges."
  exit 1
fi

ROOT_DIR="/root"
GITURL="https://github.com/helios-base/librcsc.git"
LIBRCSC="librcsc"
git clone "${GIRURL}" -o "${LIBRCSC}" "${ROOT_DIR}"

function install_package {
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