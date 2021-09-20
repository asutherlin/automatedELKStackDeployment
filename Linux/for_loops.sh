#!/bin/bash

states=('New York' 'Hawaii' 'Wisconsin' 'Florida' 'California')

for state in "${states[@]}"
do
	if [ "$state" == 'Hawaii' ]
	then
		echo "Hawaii is the best!"
	else
		echo "I'm not fond of Hawaii"
	fi
done

num=(0 1 2 3 4 5 6 7 8 9)

for nums in ${num[@]}
do
	if [ $nums -eq 3 ] || [ $nums -eq 5 ] || [ $nums -eq 7 ]
	then
		echo $nums
	fi
done

list=$(ls)

for file in $list
do
	ls $file
done

