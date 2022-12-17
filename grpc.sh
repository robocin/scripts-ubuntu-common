#!/bin/bash

function is_root {
  [ "${EUID:-$(id -u)}" -eq 0 ];
}

if ! is_root; then
  echo -e "\x1B[31m[ERROR] This script requires root privileges."
  exit 1
fi

PARENT_DIR="${1}"
CURRENT_USER=$(who | awk 'NR==1{print $1}')

if [ -z "${PARENT_DIR}" ]; then
  PARENT_DIR="/opt"
fi

GRPC_DIR="${PARENT_DIR}/grpc"
TMP_GIT_REPO_DIR="/tmp/grpc"

echo -e "\x1B[01;93mInstalling git...\n\u001b[0m"

apt install git -y

echo -e "\x1B[01;93m\nInstalling or updating grpc...\n\u001b[0m"

# reference: https://grpc.io/docs/languages/cpp/quickstart/#install-other-required-tools
apt install build-essential autoconf libtool pkg-config -y

rm -rf "${TMP_GIT_REPO_DIR}"
mkdir -p "${TMP_GIT_REPO_DIR}"

git clone --recurse-submodules https://github.com/grpc/grpc.git -o grpc "${TMP_GIT_REPO_DIR}"

mkdir -p "${TMP_GIT_REPO_DIR}/build"

rm -rf "${GRPC_DIR}" # removes the directory if it exists to avoid errors
mkdir -p "${GRPC_DIR}"

pushd "${TMP_GIT_REPO_DIR}/build" || exit 1
# reference: https://grpc.io/docs/languages/cpp/quickstart/#build-and-install-grpc-and-protocol-buffers
cmake .. -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DCMAKE_INSTALL_PREFIX="${GRPC_DIR}"
make -j "$(nproc)"
make install
popd || exit 1

rm -rf "${TMP_GIT_REPO_DIR}"

chown "${CURRENT_USER}":"${CURRENT_USER}" "${GRPC_DIR}" -R # changes the owner of the directory to the current user