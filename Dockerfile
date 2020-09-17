FROM node:12-slim

RUN apt-get update && apt-get -y install apt-utils
RUN apt-get update && apt-get -y install sudo git python3 python build-essential avahi-daemon avahi-discover avahi-utils libnss-mdns mdns-scan libavahi-compat-libdnssd-dev sysstat procps
RUN groupadd -r i2c -g 998 && groupadd -r spi -g 999 && usermod -a -G dialout,i2c,spi,netdev node

RUN echo 'node ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER node
RUN mkdir -p /home/node/
WORKDIR /home/node/
#RUN git clone https://github.com/SignalK/signalk-server.git signalk
RUN git clone https://github.com/KEGustafsson/signalk-server.git signalk
WORKDIR /home/node/signalk

# Uncomment if you want specific tag instead of latest
# RUN git fetch && git fetch --tags
# RUN git checkout v1.30.0

#RUN git fetch && git fetch --tags
RUN git checkout preferred-source-delta-filtering
#RUN git config user.email "you@example.com"
#RUN git config user.name "Your Name"
#RUN git merge --no-commit --no-ff origin/master

# Startup script
COPY --chown=node startup.sh startup.sh
RUN chmod +x startup.sh
COPY --chown=root avahi/avahi-dbus.conf /etc/dbus-1/system.d/avahi-dbus.conf

USER root
RUN mkdir -p /var/run/dbus/
RUN chmod -R 777 /var/run/dbus/
RUN mkdir -p /var/run/avahi-daemon/
RUN chmod -R 777 /var/run/avahi-daemon/
RUN chown -R avahi:avahi /var/run/avahi-daemon/
USER node

# Uncomment if you want patching enabled
ADD --chown=node patch patch
RUN git apply ./patch/*.patch

RUN npm install
RUN npm run build
RUN mkdir -p /home/node/.signalk

#server-admin-ui
WORKDIR /home/node/signalk/packages/server-admin-ui
RUN npm i
RUN npm run prepublishOnly
USER root
RUN npm link
WORKDIR /home/node/signalk
RUN npm link @signalk/server-admin-ui
USER node

EXPOSE 3000
ENV IS_IN_DOCKER true
CMD ["bash"]
