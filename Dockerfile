FROM debian:jessie
MAINTAINER Tim Haak <tim@haak.co>

ENV DEBIAN_FRONTEND="noninteractive" \
    TERM="xterm"

RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup &&\
    echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache && \
    apt-get -q update && \
    apt-get -qy dist-upgrade && \
    apt-get install -qy \
      iproute2 \
      ca-certificates \
      openssl \
      xmlstarlet \
      curl \
      sudo \
      wget \
    && \
    cd /tmp && \
    wget -O plexmediaserver.deb 'https://plex.tv/downloads/latest/1?channel=16&build=linux-ubuntu-x86_64&distro=ubuntu&X-Plex-Token=' && \
    dpkg -i plexmediaserver.deb && \
    rm -rf /tmp/*

ENV RUN_AS_ROOT="true" \
    CHANGE_DIR_RIGHTS="false" \
    CHANGE_CONFIG_DIR_OWNERSHIP="true" \
    HOME="/var/lib/plexmediaserver" \
    PLEX_DISABLE_SECURITY=1

EXPOSE 32400

ADD ./start.sh /start.sh

CMD ["/start.sh"]
