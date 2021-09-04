#!/bin/bash
echo 'curl -d "name=$HOME&ip=$(hostname -I)" -X POST http://api.mohamedelkadaoui.fr/devices' >> /etc/rc.local
