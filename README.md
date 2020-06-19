# SignalK, Telegraf, Influxdb and Grafana
Signalk-server-node, Telegraf, Influxdb and Grafana in docker-compose 
```bash
├── signalk
│   └── signalk docker files located here 
├── signalk_conf
│   └── .signalk -folder is located here (bind mount) 
└── signalk_volume
    ├── influxdb
    │   └── influx database files are located here (bind mount)
    ├── grafana
    │   └── grafana config files are located here (bind mount)
    └── telegraf
        └── telegraf config file is located here (bind mount)
```
1st Intallation:
- Run run_me_1st.sh when installing SignalK, Telegraf, Influxdb and Grafana at first time

Update/Upgarde:
- Run update.sh when need to be updated SignalK, Telegraf, Influxdb or Grafana

Program locations:
- Signalk <'ipaddress'>:3000
- Grafana <'ipadress'>:3001
- Influxdb <'ipadress'>:8086

Ports for Signalk:
- Modify docker-compose.yml to match ports used by SignalK (inputs to SignalK/docker)

Telegraf has dummy telegraf.conf installed after run_me_1st.sh was run. Edit configuration according to your needs and restart docker-compose. If you do not need telegraf, you don't need to do anything.

To use specific tag/release:
- uncomment Dockecfile tag selection and specify version there

Manual installation
- docker-compose build .
- docker-compose pull
- docker-compose up -d

Stop:
- docker-compose down

Restart:
- docker-compose restart

Test on Intel/AMD (x86_64) and ARM64 (aarch64) platforms.
