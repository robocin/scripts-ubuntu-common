#!/bin/bash

QT=${1}
DIR=${2}

CURRENT_USER=$(who | awk 'NR==1{print $1}')

if [ -z "${QT}" ]; then
  QT="6"
fi

if [ -z "${DIR}" ]; then
  DIR="/opt/qt"
fi

apt-get install git cmake python3 python3-pip build-essential libdbus-1-3 libpulse-mainloop-glib0 -y
apt-get install libgl-dev libglu-dev 'libxcb*-dev' libx11-xcb-dev libxkbcommon-x11-dev libpcre2-dev libz-dev \
                libfreetype6-dev libpng-dev libjpeg-dev libsqlite3-dev libharfbuzz-dev libb2-dev \
                libdouble-conversion-dev libmd4c-dev libssl-dev x11-xkb-utils xkb-data libxcb-xkb-dev libxkbcommon-dev \
                libvulkan1 mesa-vulkan-drivers vulkan-utils -y

pip3 install aqtinstall

aqt install-qt linux desktop "${QT}" -O "${DIR}"

chown "${CURRENT_USER}":"${CURRENT_USER}" "${DIR}" -R
chown "${CURRENT_USER}":"${CURRENT_USER}" "/usr/local/bin/aqt" -R

rm -f aqtinstall.log
