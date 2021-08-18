#!/bin/bash

# >>>>>>>>>>>> sudo setup.sh <<<<<<<<<<<
# Installation tested for Jetson Jetpack 4.5.1
# chmod +x setup.sh

# dependencies
sudo apt install python3-pip
sudo apt-get install -y libffi-dev
sudo apt-get install -y python-openssl
sudo apt-get install libssl-dev

# install Python PIP
sudo apt-get update -y
sudo apt-get install -y curl
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

# start fan and config to start at every reboot
chmod +x fan.sh
sudo ./fan.sh
