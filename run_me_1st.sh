#!/bin/bash
docker build -t signalk-server-node .
docker run --name signalk-server-node --entrypoint /home/node/signalk/bin/signalk-server signalk-server-node &
docker run --name grafana grafana/grafana &

sleep 30

mkdir -p $PWD/../signalk_conf
docker cp signalk-server-node:/home/node/.signalk/. $PWD/../signalk_conf
docker stop signalk-server-node
docker rm signalk-server-node

mkdir -p $PWD/../signalk_volume/influxdb
mkdir -p $PWD/../signalk_volume/grafana/data
mkdir -p $PWD/../signalk_volume/grafana/conf
mkdir -p $PWD/../signalk_volume/telegraf
cp telegraf.conf $PWD/../signalk_volume/telegraf/telegraf.conf

docker cp grafana:/var/lib/grafana/. $PWD/../signalk_volume/grafana/data
docker cp grafana:/usr/share/grafana/conf/. $PWD/../signalk_volume/grafana/conf
docker stop grafana
docker rm grafana

docker-compose up -d
