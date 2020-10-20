#!/bin/bash
echo
echo
echo "Select Signal K source"
echo "   1: SignalK, build from Github source"
echo "   2: SignalK, Dockedhub source (fast installation)"
read readMe2

case $readMe2 in

  [1])
    echo
    echo
    echo "Select setup"
    echo "   1: SignalK"
    echo "   2: SignalK + Influxdb and Grafana"
    echo "   3: SignalK + Influxdb + Grafana and Telegraf"
    read readMe3

    case $readMe3 in

      [1])
        cp $PWD/conf/docker-compose-sk.yml docker-compose.yml
        mkdir -p $PWD/../signalk_conf
        docker-compose down && docker-compose pull && docker-compose build --no-cache && docker-compose up -d
        ;;
      [2])
        cp $PWD/conf/docker-compose-sk_i_g.yml docker-compose.yml
        docker run --name grafana grafana/grafana &
        sleep 30
        mkdir -p $PWD/../signalk_conf
        mkdir -p $PWD/../signalk_volume/influxdb
        mkdir -p $PWD/../signalk_volume/grafana/data
        mkdir -p $PWD/../signalk_volume/grafana/conf
        docker cp grafana:/var/lib/grafana/. $PWD/../signalk_volume/grafana/data
        docker cp grafana:/usr/share/grafana/conf/. $PWD/../signalk_volume/grafana/conf
        docker stop grafana
        docker rm grafana
        docker-compose down && docker-compose pull && docker-compose build --no-cache && docker-compose up -d
        sleep 20
        curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE boatdata"
 #      curl -i -XPOST http://localhost:8086/query --data-urlencode "q=ALTER RETENTION POLICY "autogen" ON "boatdata" DURATION 7d"
        docker-compose restart
        ;;
      [3])
        cp $PWD/conf/docker-compose-sk_i_g_t.yml docker-compose.yml
        docker run --name grafana grafana/grafana &
        sleep 30
        mkdir -p $PWD/../signalk_conf
        mkdir -p $PWD/../signalk_volume/influxdb
        mkdir -p $PWD/../signalk_volume/grafana/data
        mkdir -p $PWD/../signalk_volume/grafana/conf
        mkdir -p $PWD/../signalk_volume/telegraf
        cp $PWD/conf/telegraf.conf $PWD/../signalk_volume/telegraf/telegraf.conf
        docker cp grafana:/var/lib/grafana/. $PWD/../signalk_volume/grafana/data
        docker cp grafana:/usr/share/grafana/conf/. $PWD/../signalk_volume/grafana/conf
        docker stop grafana
        docker rm grafana
        docker-compose down && docker-compose pull && docker-compose build --no-cache && docker-compose up -d
        sleep 20
        curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE boatdata"
#       curl -i -XPOST http://localhost:8086/query --data-urlencode "q=ALTER RETENTION POLICY "autogen" ON "boatdata" DURATION 7d"
        ;;
      *)
        echo "Unknown selection"
        ;;

    esac
    ;;

  [2])
    echo
    echo
    echo "Select setup"
    echo "   1: SignalK"
    echo "   2: SignalK + Influxdb and Grafana"
    echo "   3: SignalK + Influxdb + Grafana and Telegraf"
    read readMe4

    case $readMe4 in

      [1])
        cp $PWD/conf/docker-compose-sk2.yml docker-compose.yml
        mkdir -p $PWD/../signalk_conf
        docker-compose down && docker-compose pull && docker-compose build --no-cache && docker-compose up -d
        ;;
      [2])
        cp $PWD/conf/docker-compose-sk2_i_g.yml docker-compose.yml
        docker run --name grafana grafana/grafana &
        sleep 30
        mkdir -p $PWD/../signalk_conf
        mkdir -p $PWD/../signalk_volume/influxdb
        mkdir -p $PWD/../signalk_volume/grafana/data
        mkdir -p $PWD/../signalk_volume/grafana/conf
        docker cp grafana:/var/lib/grafana/. $PWD/../signalk_volume/grafana/data
        docker cp grafana:/usr/share/grafana/conf/. $PWD/../signalk_volume/grafana/conf
        docker stop grafana
        docker rm grafana
        docker-compose down && docker-compose pull && docker-compose build --no-cache && docker-compose up -d
        sleep 20
        curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE boatdata"
 #      curl -i -XPOST http://localhost:8086/query --data-urlencode "q=ALTER RETENTION POLICY "autogen" ON "boatdata" DURATION 7d"
        docker-compose restart
        ;;
      [3])
        cp $PWD/conf/docker-compose-sk2_i_g_t.yml docker-compose.yml
        docker run --name grafana grafana/grafana &
        sleep 30
        mkdir -p $PWD/../signalk_conf
        mkdir -p $PWD/../signalk_volume/influxdb
        mkdir -p $PWD/../signalk_volume/grafana/data
        mkdir -p $PWD/../signalk_volume/grafana/conf
        mkdir -p $PWD/../signalk_volume/telegraf
        cp $PWD/conf/telegraf.conf $PWD/../signalk_volume/telegraf/telegraf.conf
        docker cp grafana:/var/lib/grafana/. $PWD/../signalk_volume/grafana/data
        docker cp grafana:/usr/share/grafana/conf/. $PWD/../signalk_volume/grafana/conf
        docker stop grafana
        docker rm grafana
        docker-compose down && docker-compose pull && docker-compose build --no-cache && docker-compose up -d
        sleep 20
        curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE boatdata"
#       curl -i -XPOST http://localhost:8086/query --data-urlencode "q=ALTER RETENTION POLICY "autogen" ON "boatdata" DURATION 7d"
        ;;
      *)
        echo "Unknown selection"
        ;;

    esac
    ;;

esac
