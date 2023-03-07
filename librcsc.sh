#!/bin/bash

function is_root {
  [ "${EUID:-$(id -u)}" -eq 0 ];
}

if ! is_root; then
  echo -e "\x1B[31m[ERROR] This script requires root privileges."
  exit 1
fi

GITHUB_LIBRCSC_URL="https://github.com/helios-base/librcsc.git"
tmp_dir="/tmp/librcsc"

rm -rf "${tmp_dir}"
mkdir -p "${tmp_dir}"

git clone "${GITHUB_LIBRCSC_URL}" -o "librcsc" "${tmp_dir}"

pushd "${tmp_dir}" || exit 1
./bootstrap && ./configure --prefix "/opt/librcsc" && make -j"$(nproc)" && make install
popd || exit 1

rm -rf "${tmp_dir}"