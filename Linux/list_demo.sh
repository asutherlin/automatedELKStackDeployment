#!/bin/bash

mylist=(1 2 3 4 5)
echo ${mylist[@]}

dow=('mon' 'tues' 'wed' 'thurs' 'fri' 'sat' 'sun')
echo ${dow[2]}

echo {0..5}
echo $(ls)
