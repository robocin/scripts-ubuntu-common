FROM robocin/cpp-ubuntu-20.04:latest

ARG QT=5.15.2
RUN robocin-install \
    "qt ${QT}" \
    boost
    
COPY flex.sh flex.sh
COPY bison.sh bison.sh
COPY boost.sh boost.sh
COPY rcsoccersim.sh rcsoccersim.sh

ENV PATH=/opt/rcssserver/bin:/opt/rcssmonitor/bin:/opt/qt/${QT}/gcc_64/bin:$PATH
COPY /opt/qt/${QT}/gcc_64/lib/* /usr/lib

RUN apt install -yq flex bison
RUN ./rcsoccersim.sh "rcssmonitor" 