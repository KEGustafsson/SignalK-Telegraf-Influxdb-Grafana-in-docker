# SignalK, Telegraf, Influxdb and Grafana in docker
Signalk-server, Telegraf, Influxdb and Grafana in docker. mDNS services (no-root) are discoverable from docker.
```bash
git clone https://github.com/KEGustafsson/SignalK-Telegraf-Influxdb-Grafana-in-docker.git

├── signalk
│   └── signalk docker files located here 
├── signalk_conf
│   └── .signalk -folder is located here (bind mount) 
└── signalk_volume
    ├── influxdb
    │   └── influx database files are located here (bind mount)
    ├── grafana
    │   └── grafana config files are located here (bind mount)
    └── telegraf
        └── telegraf config file is located here (bind mount)
```
1st Intallation:
- Run run_me_1st.sh when installing SignalK, Telegraf, Influxdb and Grafana at first time
- In case Influxdb is selected, then database "boatdata" is generated. If you want retention policy active, uncomment respective lines. Alter settings before running it if you want other name and different retention policy for the database.
```bash
Select which node version will be used
   1: Node10-slim
   2: Node12-slim  (use this if you don't know)

1st time installation, select 1-3
   1: SignalK
   2: SignalK + Influxdb and Grafana
   3: SignalK + Influxdb + Grafana and Telegraf
```

Update/Upgarde:
- Run update.sh when need to be updated SignalK, Telegraf, Influxdb or Grafana

SignalK
- Running in default port 3000

Grafana:
- Running in port 3001
- TODO: Data Source (boatdata) is automatically provisioned to Grafana

Influxdb:
- Running in default port 8086
 
Telegraf:
- Telegraf has a dummy telegraf.conf installed after run_me_1st.sh was run. Edit configuration according to your needs (input: data sources and output: influxdb database, urls, username and password) and restart docker-compose. If you do not need telegraf, you don't need to do anything.

To use specific SignalK tag/release:
- uncomment Dockerfile tag selection and specify version there

To use specific SignalK ENV parameters (https://github.com/SignalK/signalk-server#environment-variables):
- uncomment Dockerfile ENV selection and specify parameters there

Docker & Docker-compose:
- Install proper dependencies, Docker and Docker Compose
```bash
curl -sSL https://get.docker.com | sh
sudo apt-get install -y libffi-dev libssl-dev
sudo apt-get install -y python3 python3-pip
sudo apt-get remove python-configparser
sudo pip3 install docker-compose
```

Manual installation
- docker-compose build .
- docker-compose pull
- docker-compose up -d

Up/Down:
- docker-compose up -d (-d run service as a daemon)
- docker-compose down

Start/Stop/Restart:
- docker-compose start 
- docker-compose stop
- docker-compose restart

Start/Stop individual service e.g. SignalK and rest of the stack will remain untouched
- docker-compose start signalk-server
- docker-compose stop signalk-server

Test on Intel/AMD (x86_64) and ARM64 (aarch64) platforms.
