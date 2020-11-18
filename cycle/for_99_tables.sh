#!/bin/bash

# Date: 2020-11-12
# Author: zoulongbin
# Description: 9 * 9 multiplication tables
# Version: 1.0

for i in {1..9}
do
   echo -e "\n######"
  for j in {1..9}
  do
    if [ $i -le $j ];then
       echo "$j * $i = $(($i*$j))"
    fi
  done
done
