#!/bin/bash
echo "Current System Info"
echo -e "\nToday's date is: $(date)\n"
echo -e "The Machine you're using: $(uname)\n"
echo -e "Your IP address is: $(hostname -I)\n"
echo -e "Your Hostname is: $(hostname)\n"
echo -e "Your DNS info: \n$(dig UbuntuDesktop)\n"
echo -e "Available memmory: \n$(free -h)\n"
echo -e "Current Disk Usage: \n$(du)\n"
echo -e "CPU info: \n$(cat /proc/cpuinfo)\n"
echo -e "Current user: $USER\n"

