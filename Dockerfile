FROM node:12-slim

RUN \
        apt-get update && apt-get -y install apt-utils && \
        apt-get update && apt-get -y install sudo git python3 python build-essential avahi-daemon avahi-discover avahi-utils libnss-mdns mdns-scan libavahi-compat-libdnssd-dev sysstat procps && \
        groupadd -r i2c -g 998 && groupadd -r spi -g 999 && usermod -a -G dialout,i2c,spi,netdev node && \
        echo 'node ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER node
RUN mkdir -p /home/node/
WORKDIR /home/node/
#RUN git clone https://github.com/SignalK/signalk-server.git signalk
RUN git clone https://github.com/KEGustafsson/signalk-server.git signalk
WORKDIR /home/node/signalk
RUN git checkout preferred-source-delta-filtering
COPY --chown=node startup.sh startup.sh
RUN chmod +x startup.sh
COPY --chown=root avahi/avahi-dbus.conf /etc/dbus-1/system.d/avahi-dbus.conf
USER root
RUN \
        mkdir -p /var/run/dbus/ && \
        chmod -R 777 /var/run/dbus/ && \
        mkdir -p /var/run/avahi-daemon/ && \
        chmod -R 777 /var/run/avahi-daemon/ && \
        chown -R avahi:avahi /var/run/avahi-daemon/
USER node
ADD --chown=node patch patch
RUN \
        git apply ./patch/*.patch && \
        npm install && \
        npm run build && \
        mkdir -p /home/node/.signalk

#server-admin-ui
WORKDIR /home/node/signalk/packages/server-admin-ui
RUN \
        npm i && \
        npm run prepublishOnly
USER root
RUN npm link
WORKDIR /home/node/signalk
RUN npm link @signalk/server-admin-ui
USER node
EXPOSE 3000
ENV IS_IN_DOCKER true
CMD ["bash"]
