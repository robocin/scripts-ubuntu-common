#!/bin/bash

function is_root {
  [ "${EUID:-$(id -u)}" -eq 0 ];
}

if ! is_root; then
  echo -e "\x1B[31m[ERROR] This script requires root privileges."
  exit 1
fi

QT="${1}"
DIR="${2}"
TMP_WORK_DIR="/tmp/qt"

CURRENT_USER=$(who | awk 'NR==1{print $1}')

if [ -z "${QT}" ]; then
  QT="6"
fi

if [ -z "${DIR}" ]; then
  DIR="/opt/qt"
fi

apt install 'libxcb*-dev' \
            build-essential \
            libb2-dev \
            libdbus-1-3 \
            libdouble-conversion-dev \
            libfreetype6-dev \
            libgl-dev libglu-dev \
            libharfbuzz-dev \
            libjpeg-dev \
            libmd4c-dev \
            libpcre2-dev \
            libpng-dev \
            libpulse-mainloop-glib0 \
            libsqlite3-dev \
            libssl-dev \
            libvulkan1 \
            libwayland-dev \
            libx11-xcb-dev \
            libxcb-xkb-dev \
            libxkbcommon-dev \
            libxkbcommon-x11-dev \
            libz-dev \
            mesa-vulkan-drivers \
            vulkan-tools \
            x11-xkb-utils \
            xkb-data \
            '^libxcb.*-dev' \
            libx11-xcb-dev \
            libglu1-mesa-dev \
            libxrender-dev \
            libxi-dev -y

pip3 install aqtinstall

rm -rf "${TMP_WORK_DIR}"
mkdir -p "${TMP_WORK_DIR}"

pushd "${TMP_WORK_DIR}" || exit 1
aqt install-qt linux desktop "${QT}" -O "${DIR}"
popd || exit 1

rm -rf "${TMP_WORK_DIR}"

chown "${CURRENT_USER}":"${CURRENT_USER}" "${DIR}" -R
chown "${CURRENT_USER}":"${CURRENT_USER}" "/usr/local/bin/aqt" -R
