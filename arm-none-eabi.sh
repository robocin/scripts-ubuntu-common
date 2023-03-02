#!/bin/bash

function is_root {
  [ "${EUID:-$(id -u)}" -eq 0 ];
}

if ! is_root; then
  echo -e "\x1B[31m[ERROR] This script requires root privileges."
  exit 1
fi

ARM_TOOLCHAIN_VERSION="${1}"
PARENT_DIR="${2}"
CURRENT_USER=$(who | awk 'NR==1{print $1}')

if [ -z "${PARENT_DIR}" ]; then
  PARENT_DIR="/opt"
fi

ARM_NONE_EABI_DIR="${PARENT_DIR}/arm-none-eabi"
TMP_WORK_DIR="/tmp/arm-none-eabi"

if [ -z "${VERSION}" ]; then
  VERSION="latest"
fi

if [ "${VERSION}" = "latest" ]; then
  ARM_TOOLCHAIN_VERSION=$(curl -s https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads | grep -Po '<h4>Version \K.+(?=</h4>)')
fi

rm -rf "${TMP_WORK_DIR}"
mkdir -p "${TMP_WORK_DIR}"

pushd "${TMP_WORK_DIR}" || exit 1
curl -Lo arm-gnu-toolchain.tar.xz "https://developer.arm.com/-/media/Files/downloads/gnu/${ARM_TOOLCHAIN_VERSION}/binrel/arm-gnu-toolchain-${ARM_TOOLCHAIN_VERSION}-x86_64-arm-none-eabi.tar.xz"

rm -rf "${ARM_NONE_EABI_DIR}"
mkdir -p "${ARM_NONE_EABI_DIR}"

tar -xf arm-gnu-toolchain.tar.xz --strip-components=1 -C "${ARM_NONE_EABI_DIR}"
popd || exit 1

rm -rf "${TMP_WORK_DIR}"

chown "${CURRENT_USER}":"${CURRENT_USER}" "${ARM_NONE_EABI_DIR}" -R
