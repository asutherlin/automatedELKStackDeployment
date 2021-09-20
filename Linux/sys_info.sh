#!/bin/bash

if [ $UID -eq 0 ]
then
	echo "Do not run this script with sudo"
	exit
fi

# variables
commands=('date' 'uname' 'hostmname -s')
files=('/etc/passwd' '/etc/shadow)
output=~/research/sys_info2.txt
ip=$(ip addr | grep inet | tail -2 | head -1)
execs=$(find /home -type f -perm 777)
paths=$(PATH[~/etc0)

# If there isn't a directory of research, create one
if [ ! -d $HOME/research ]
then
	mkdir $HOME/research
fi

# If there is already a file sys_info.txt in the research directory, remove it 
if [ -f $ouput ]
then
	rm $ouput
fi

# This will show the permissions of all the files in the my_scripts directory
for perm in $HOME/sysadmin/my_script
do
	ls -lah 
done

# Checks the sudo abilities of each user that has a home folder on the system
for 

echo "A Quick System Audit Script" >$output
date >>$output
echo "" >>$output
echo "Machine Type Info:" >>$output
echo $MACHTYPE >>$output
echo -e "Uname info: $(uname -a) \n" >>$output
echo -e "IP Info: $ip >>$output
echo -e "Hostname: $(hostname -s) \n" >>$output
echo "DNS Servers: " >>$output
cat /etc/resolv.conf >>$output
echo -e "\nMemory Info:" >>$output
free >>$output
echo -e "\nCPU Info:" >>$output
lscpu | grep CPU >>$output
echo -e "\nDisk Usage:" >>~/ | head -2 >>$output
echo -e "\nWho is logged in: \n $(who -a) \n" >>$output
echo -e "\nExec Files:" >>$output

ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >>$output

# Print out files names that have permission of 777
for exec in ${execs[@]}
do
	echo $exec >> $ouput
done

echo -e "\nTOp10Processes" >> $output

# Show paths for the shadow and passwd files in the /etc directory into a list
for file in ${files[@]}
do
	ls -l $file >> $output
done

for result in $(${commands[@]})
do
	results=$(${commands[$i]})
	echo "Results of \"${commands[$i]}\" command:"
	echo $results
	echo ""
done
