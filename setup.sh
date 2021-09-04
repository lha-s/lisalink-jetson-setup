#!/bin/bash

# >>>>>>>>>>>> sudo setup.sh <<<<<<<<<<<
# Installation tested for Jetson Jetpack 4.5.1
# chmod +x setup.sh
# doc: https://opendatacam.github.io/opendatacam/documentation/jetson/JETSON_NANO.html#using-barrel-jack-5v---4a

# set jetson on 10W (0 for 10W, 1 for 5W)
sudo nvpmodel -m 0

# start fan and config to start at every reboot
chmod +x fan.sh
sudo ./fan.sh

# config restart of opendatacam and telegram notification
chmod +x reboot-config.sh
sudo ./reboot-config.sh

# protect /etc/rc.local
sudo chmod u+x /etc/rc.local

# install nodejs for telegram bot
wget -qO- https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs
sudo apt-get install npm
sudo npm install pm2 -g

# pre-requisit for certificates by fixing the date
sudo date -s "$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f5-8)Z"

#In order to reduce memory pressure (and crashes), it is a good idea to setup a 6GB swap partition. (Nano has only 4GB of RAM)
git clone https://github.com/JetsonHacksNano/installSwapfile
chmod 777 installSwapfile/installSwapfile.sh
./installSwapfile/installSwapfile.sh

# dependencies
sudo apt-get update -y
sudo apt-get install -y curl
sudo apt install -y python3-pip
sudo apt-get install -y libssl-dev

# install Python PIP
curl -sSL https://bootstrap.pypa.io/pip/2.7/get-pip.py | sudo python

# install Docker Compose build dependencies
sudo apt-get install -y libffi-dev
sudo apt-get install -y python-openssl

# install Docker Compose via pip (latest= 1.26.0?)
export DOCKER_COMPOSE_VERSION=1.24.0
sudo pip install docker-compose=="${DOCKER_COMPOSE_VERSION}"

# Download install script
wget -N https://raw.githubusercontent.com/opendatacam/opendatacam/v3.0.1/docker/install-opendatacam.sh

# Give exec permission
chmod 777 install-opendatacam.sh

# NB: You will be asked for sudo password when installing the docker container
# You might want to stop all docker container running before starting OpenDataCam
# sudo docker stop $(sudo docker ps -aq)

# Install command for Jetson Nano
# NB: Will run from demo file, you can change this after install, see "5. Customize OpenDataCam"
./install-opendatacam.sh --platform nano

# shutdown for modifications
sudo docker-compose down

# Edit configuration file config.json to keep only "person"
cp config.json.template config.json

# Downgrade mongodb version to 4.4.8
cp docker-compose.yml.template docker-compose.yml

# final start
sudo docker-compose up -d

