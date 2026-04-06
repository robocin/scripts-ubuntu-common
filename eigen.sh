#!/bin/bash

function is_root {
  [ "${EUID:-$(id -u)}" -eq 0 ];
}

if ! is_root; then
  echo -e "\x1B[31m[ERROR] This script requires root privileges."
  exit 1
fi

function install_release {
    tar -xf $ARCHIVE_NAME
    cd $EXTRACTED_DIR
    mkdir -p build
    cd build
    cmake ..
    make install
    cd ..
}

EIGEN_VERSION="3.4.1"
SOURCE_URL="https://gitlab.com/libeigen/eigen/-/archive/${EIGEN_VERSION}/eigen-${EIGEN_VERSION}.tar.bz2"
ARCHIVE_NAME="eigen-${EIGEN_VERSION}.tar.gz"
EXTRACTED_DIR="eigen-${EIGEN_VERSION}"
TMP_DIR="/tmp/eigen"

rm -rf "${TMP_DIR}"
mkdir -p "${TMP_DIR}"

echo -e "\x1B[01;93mDownloading Eigen ${EIGEN_VERSION}...\n\u001b[0m"

curl -L $SOURCE_URL -o $ARCHIVE_NAME

echo -e "\x1B[01;93m\Extracting and installing...\n\u001b[0m"

pushd "${TMP_DIR}" || exit 1
install_release
popd || exit 1
rm -rf $ARCHIVE_NAME $EXTRACTED_DIR
