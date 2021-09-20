#1/bin/bash
num=5
if [ ! -d /home/sysadmin/research ]
then
	mkdir /home/sysadmin/research
else
	echo "research folder already there"
fi

x="'hello world'"
y="'hello world'"

if [ $(whoami) != "instructor" ]
then
	echo "Bro, get a life"
fi

