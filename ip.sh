#!/bin/bash
curl -d "name=$HOME&ip=$(hostname -I)" -X POST http://api.mohamedelkadaoui.fr/devices
