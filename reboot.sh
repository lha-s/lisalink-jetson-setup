#!/bin/bash

# catch user logname
cp ./user.sh ~/
runuser -l  lisalink -c '~/user.sh'

user=$(<~/.logname)

sudo echo "sudo /home/$user/lisalink-setup/docker-compose restart" >> /etc/rc.local
