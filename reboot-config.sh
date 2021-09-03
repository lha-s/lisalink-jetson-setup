#!/bin/bash
echo '"sudo docker-compose restart"' >> /etc/rc.local

echo 'sudo pm2 start /home/lisalink/lisalink-setup/lisalink-bot/index.js --name bot-telegram' >> /etc/rc.local
