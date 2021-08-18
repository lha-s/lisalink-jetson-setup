#!/bin/bash

# Run fan (max speed 255)
sudo sh -c 'echo 100 > /sys/devices/pwm-fan/target_pwm'

# Run fan on reboot automatically
touch /etc/rc.local
echo "#!/bin/bash" >> /etc/rc.local
echo "sleep 10" >> /etc/rc.local
echo "sudo /usr/bin/jetson_clocks" >> /etc/rc.local
echo "sudo sh -c 'echo 100 > /sys/devices/pwm-fan/target_pwm'" >> /etc/rc.local

sudo chmod u+x /etc/rc.local
