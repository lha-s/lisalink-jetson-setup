#!/bin/bash

# catch user logname
sudo ./user.sh

user=$(<~/.logname)

sudo echo "sudo /home/$user/lisalink-setup/docker-compose restart" >> /etc/rc.local
