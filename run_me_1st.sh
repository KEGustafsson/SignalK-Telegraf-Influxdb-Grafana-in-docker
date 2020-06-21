#!/bin/bash
echo "1st time installation, select 1-3"
echo "   1: SignalK"
echo "   2: SignalK + Influxdb and Grafana"
echo "   3: SignalK + Influxdb + Grafana and Telegraf"
read readMe

case $readMe in

  [1])
    cp $PWD/conf/docker-compose-sk.yml docker-compose.yml
    docker build -t signalk-server-node .
    docker run --name signalk-server-node --entrypoint /home/node/signalk/bin/sign$
    sleep 30
    mkdir -p $PWD/../signalk_conf
    docker cp signalk-server-node:/home/node/.signalk/. $PWD/../signalk_conf
    docker stop signalk-server-node
    docker rm signalk-server-node
    ;;

  [2])
    cp $PWD/conf/docker-compose-sk_i_g.yml docker-compose.yml
    docker build -t signalk-server-node .
    docker run --name signalk-server-node --entrypoint /home/node/signalk/bin/sign$
    docker run --name grafana grafana/grafana &
    sleep 30
    mkdir -p $PWD/../signalk_conf
    docker cp signalk-server-node:/home/node/.signalk/. $PWD/../signalk_conf
    docker stop signalk-server-node
    docker rm signalk-server-node
    mkdir -p $PWD/../signalk_volume/influxdb
    mkdir -p $PWD/../signalk_volume/grafana/data
    mkdir -p $PWD/../signalk_volume/grafana/conf
    docker cp grafana:/var/lib/grafana/. $PWD/../signalk_volume/grafana/data
    docker cp grafana:/usr/share/grafana/conf/. $PWD/../signalk_volume/grafana/conf
    docker stop grafana
    docker rm grafana
    docker-compose up -d
    sleep 20
    curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE boatdata"
    curl -i -XPOST http://localhost:8086/query --data-urlencode "q=ALTER RETENTION POLICY "autogen" ON "boatdata" DURATION 7d"
    ;;

  [3])
    cp $PWD/conf/docker-compose-sk_i_g_t.yml docker-compose.yml
    docker build -t signalk-server-node .
    docker run --name signalk-server-node --entrypoint /home/node/signalk/bin/sign$
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
    cp $PWD/conf/telegraf.conf $PWD/../signalk_volume/telegraf/telegraf.conf
    docker cp grafana:/var/lib/grafana/. $PWD/../signalk_volume/grafana/data
    docker cp grafana:/usr/share/grafana/conf/. $PWD/../signalk_volume/grafana/conf
    docker stop grafana
    docker rm grafana
    docker-compose up -d
    sleep 20
    curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE boatdata"
    curl -i -XPOST http://localhost:8086/query --data-urlencode "q=ALTER RETENTION POLICY "autogen" ON "boatdata" DURATION 7d"
    ;;

  *)
    echo "Unknown selection"
    ;;

esac
