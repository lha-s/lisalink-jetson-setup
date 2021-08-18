#!/bin/bash

# >>>>>>>>>>>> sudo setup.sh <<<<<<<<<<<
# Installation tested for Jetson Jetpack 4.5.1
# chmod +x setup.sh

# dependencies
sudo apt install python3-pip
sudo apt-get install -y libffi-dev
sudo apt-get install -y python-openssl
sudo apt-get install libssl-dev
sudo apt-get install curl

# install Python PIP
sudo apt-get update -y
sudo apt-get install -y curl
curl -sSL https://bootstrap.pypa.io/get-pip.py | sudo python

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

sudo docker-compose stop

# Edit configuration file config.json to keep only "person"
sed -i 's/TO_REPLACE_VIDEO_INPUT/usbcam/' config.json

sed -e '/bicycle/ s/^#*/#/g' -i config.json
sed -e '/truck/ s/^#*/#/g' -i config.json
sed -e '/motorbike/ s/^#*/#/g' -i config.json
sed -e '/car/ s/^#*/#/g' -i config.json
sed -e '/bus/ s/^#*/#/g' -i config.json

sed -i 's/.*VALID_CLASSES.*/  "VALID_CLASSES": ["person"],/' config.json

# Run fan (max speed 255)
#sudo sh -c 'echo 100 > /sys/devices/pwm-fan/target_pwm' 

# Run fan on reboot automatically
touch /etc/rc.local
echo "#!/bin/bash" >> /etc/rc.local
echo "sleep 10" >> /etc/rc.local
echo "sudo /usr/bin/jetson_clocks" >> /etc/rc.local
echo "sudo sh -c 'echo 100 > /sys/devices/pwm-fan/target_pwm'" >> /etc/rc.local

sudo chmod u+x /etc/rc.local

#reboot
sudo reboot

