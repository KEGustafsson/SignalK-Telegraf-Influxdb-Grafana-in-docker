FROM node:10-slim

RUN apt-get update && apt-get -y install sudo git python3 python build-essential libavahi-compat-libdnssd-dev
RUN groupadd -r i2c -g 998 && groupadd -r spi -g 999 && usermod -a -G dialout,i2c,spi node

RUN echo 'node ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER node
RUN mkdir -p /home/node/
WORKDIR /home/node/
RUN git clone https://github.com/SignalK/signalk-server.git signalk
WORKDIR /home/node/signalk

# Uncomment if you want specific tag instead of latest
# RUN git fetch && git fetch --tags
# RUN git checkout v1.30.0

RUN npm install
RUN npm run build
RUN mkdir -p /home/node/.signalk

EXPOSE 3000
ENV IS_IN_DOCKER true
CMD ["bash"]
