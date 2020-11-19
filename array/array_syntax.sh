#!/bin/bash

# Date: 2020-11-18
# Author: zoulongbin
# Description: array syntax
# Version: 1.0

### syntax 1
array01=(a b c)

echo ${array01[*]}
echo ${array01[@]}
echo ${#array01[*]}
echo ${#array01[@]}
echo ${array01[0]}
echo ${array01[1]}
echo ${array01[2]}


echo -e "\n"

### syntax 2
array02=([10]=one [11]=two [12]=three)

echo ${array02[10]}
echo ${array02[11]}
echo ${array02[12]}


echo -e "\n"

### syntax 3
array03[20]=xiaoming;array03[21]=xiaohong;array03[22]=xiaozhang

echo ${array03[20]}
echo ${array03[21]}
echo ${array03[22]}


echo -e "\n"

### syntax 4
array04=(1 2 3 4)

echo ${array04[*]}
array04[2]=three
echo ${array04[*]}
unset array04[3]
echo ${array04[*]}


echo -e "\n"

###syntax 5
array05=(one two three four)

echo ${array05[*]}
echo ${array05[*]:1:3}
echo ${array05[*]/two/xiaoming}
