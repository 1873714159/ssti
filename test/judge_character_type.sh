#!/bin/bash

# Date: 2020-11-23
# Author: zoulongbin
# Description: judgemnt imput character is letter or integer or string
# version: 1.0

read -p "请输入: " char


### No 1
if [[ $char =~ ^[a-zA-Z]+$ ]];then
  echo "$char is letter"
elif [[ $char =~ ^[0-9.]+$ ]];then
  echo "$char is integer"
else
  echo "$char is string"
fi

### No 2
#if [ -z $char ];then
#  echo "$char is string"
#elif [ -z `echo $char | sed 's/[a-zA-Z]//g'` ];then
#  echo "$char is letter"
#elif [ -z `echo $char | sed 's/[0-9.]//g'` ];then
#  echo "$char is integer"
#else
#   echo "$char is string"
#fi
