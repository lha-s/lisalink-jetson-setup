#!/bin/bash
sudo echo 'sudo docker-compose restart' >> /etc/rc.local

sudo echo 'sudo pm2 start /home/lisalink/lisalink-setup/lisalink-bot/index.js --name bot-telegram' >> /etc/rc.local
#sudo echo 'sudo pm2 delete bot-telegram' >> /etc/rc.local
