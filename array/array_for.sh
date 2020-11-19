#!/bin/bash

# Date:2020-11-19
# Author: zoulongbin
# Description: array cycle
# Version: 1.0

array01=(1 2 3 4 5 6)

for i in ${array01[*]}
do
   echo $i
done

echo -e "\n"



array02=(6 7 8 9 10)

for ((j=0;j<${#array02[*]};j++))
do
  echo ${array02[j]}
done

echo -e "\n"



array03=(11 12 13 14 15)
k=0
while ((k<${#array03[*]}))
do
   echo ${array03[k]}
   ((k++))
done

echo -e "\n"



userinfo=($(cat /etc/passwd))

for ((f=0;f<${#userinfo[*]};f++))
do
    echo "The $f user information is { ${userinfo[f]} }"
done
