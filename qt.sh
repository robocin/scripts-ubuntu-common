QT=${1}

if [ -z ${QT} ]
then
  QT="5.15.2"
fi

apt-get install git cmake python3 python3-pip build-essential libdbus-1-3 libpulse-mainloop-glib0 -y

pip3 install aqtinstall

aqt install --outputdir /opt/qt ${QT} linux desktop