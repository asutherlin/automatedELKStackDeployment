#!/bin/bash
mkdir ~/research 2> /dev/null
echo -e "\n777 Files: " >> ~/research/sys_info.txt
find / -type f -perm 777 >> ~/research/sys_info.txt
echo -e "\nTop 10 Processes: " >> ~/research/sys_info.txt
ps aux -m | awk '{print $1, $2, $3, $11}' | head >> ~/research/sys_info.txt
