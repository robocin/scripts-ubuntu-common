#!/bin/bash

PARENT_DIR=${1}

CURRENT_USER=$(who | awk 'NR==1{print $1}')

if [ -z "${PARENT_DIR}" ]; then
  PARENT_DIR="/opt"
fi

DIR="${PARENT_DIR}/libtorch"
OUTPUT_FILE="${PARENT_DIR}/libtorch.zip"

LINK="https://download.pytorch.org/libtorch/nightly/cpu/libtorch-cxx11-abi-shared-with-deps-latest.zip"

mkdir -p "${PARENT_DIR}"
wget -O "${OUTPUT_FILE}" "${LINK}"
rm -f -r "${DIR}" # removes the old folder, if exists.
unzip -o "${OUTPUT_FILE}" -d "${PARENT_DIR}"
rm -f "${OUTPUT_FILE}"

chown "${CURRENT_USER}":"${CURRENT_USER}" "${DIR}" -R