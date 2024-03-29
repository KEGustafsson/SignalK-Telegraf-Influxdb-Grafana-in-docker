# SignalK, Telegraf, Influxdb and Grafana in docker
SignalK-server, Telegraf, Influxdb and Grafana in docker. mDNS services (no-root) are discoverable from docker.
SignalK is based on Node 16. Previous versions are based on Node 12 & 14. See upgrade noted below.
```bash
git clone https://github.com/KEGustafsson/SignalK-Telegraf-Influxdb-Grafana-in-docker.git

├── SignalK-Telegraf-Influxdb-Grafana-in-docker
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
- Run run_me_1st.sh when installing SignalK, Telegraf, Influxdb and Grafana at first time (do not use sudo to run this script).
- In case Influxdb is selected, then database "boatdata" is generated. If you want retention policy active, uncomment respective lines. Alter settings before running it if you want other name and different retention policy for the database.
```bash
Select setup
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

To use specific SignalK ENV parameters (https://github.com/SignalK/signalk-server#environment-variables):
- uncomment Dockerfile ENV selection and specify parameters there

Docker & Docker-compose:
- Install proper dependencies, Docker and Docker Compose
```bash
curl -sSL https://get.docker.com | sh
sudo apt-get install -y libffi-dev libssl-dev
sudo apt-get install -y python3 python3-pip
sudo apt-get remove python-configparser
python3 -m pip install -U pip
sudo pip3 install docker-compose
```
- Post-installation steps for Linux (https://docs.docker.com/engine/install/linux-postinstall/)
```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```

Manual installation
```bash
docker-compose pull
docker-compose up -d
```

Up/Down:
```bash
docker-compose up -d
docker-compose down
```
(-d run service as a daemon)

Start/Stop/Restart:
```bash
docker-compose start
docker-compose stop
docker-compose restart
```

Start/Stop/Restart individual service e.g. SignalK and rest of the stack will remain untouched
```bash
docker-compose start signalk-server
docker-compose stop signalk-server
docker-compose restart signalk-server
```

Note for upgrading: 
Old versions were using Node 12 & 14 and therefore you need to remove /home/node/.signalk/node_modules -folder and re-install node modules.

Enter inside signalk-server docker and remove folder, below is example: 
```bash
docker exec -it signalk-server bash
cd ./../.signalk
rm -rf node_modules
npm i
exit
```
and then restart docker or docker-compose
```bash
docker-compose restart signalk-server
```

Test on Intel/AMD (x86_64) and ARM64 (aarch64) platforms.
