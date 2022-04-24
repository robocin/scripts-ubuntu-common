#!/bin/bash

PARENT_DIR=${1}

if [ -z "${PARENT_DIR}" ]; then
  PARENT_DIR="/opt"
fi

DIR="${PARENT_DIR}/eigen-master"
OUTPUT_FILE="${PARENT_DIR}/eigen-master.zip"

LINK="https://gitlab.com/libeigen/eigen/-/archive/master/eigen-master.zip"

mkdir -p "${PARENT_DIR}"
wget -O "${OUTPUT_FILE}" "${LINK}"
rm -f -r "${DIR}" # removes the old folder, if exists.
unzip -o "${OUTPUT_FILE}" -d "${PARENT_DIR}"
rm -f "${OUTPUT_FILE}"

mkdir "${DIR}/build" && cd "${DIR}/build" && cmake .. && make install

rm -f -r "${DIR}"