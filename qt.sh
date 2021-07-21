#!/bin/bash

QT=${1}
DIR=${2}

CURRENT_USER=$(who | awk 'NR==1{print $1}')

if [ -z "${QT}" ]; then
  QT="6.2.0"
fi

if [ -z "${DIR}" ]; then
  DIR="/opt/qt"
fi

apt-get install git cmake python3 python3-pip build-essential libdbus-1-3 libpulse-mainloop-glib0 -y
apt-get install libssl-dev x11-xkb-utils xkb-data libxcb-xkb-dev libxkbcommon-dev -y

pip3 install aqtinstall

aqt install --outputdir "${DIR}" "${QT}" linux desktop

chown "${CURRENT_USER}":"${CURRENT_USER}" "${DIR}" -R

rm aqtinstall.log
