#!/bin/bash

# Date: 2020-11-16
# Author: zoulongbin
# Description: compare two integer size
# Version: 2.0

read -p "Please input first integer Number: " firstnum
read -p "Please input second integer Number: " secondnum

expr $firstnum + $secondnum + 1 > /dev/null 2>&1

revalue=$?

###判断输入整数不能为空并且为正整数
if [ -z "$firstnum" -a -z "$secondnum" ] 
  then
    echo -e "\n### The first number and the second number not null  ###\n"
    exit 1
elif [ -z "$secondnum" ]
  then    
    echo -e "\n### The second number not null! ###\n"
    exit 1
elif [ -z "$firstnum" ]
  then
    echo -e "\n### The first number not null! ###\n"
    exit 1
elif [ $revalue -ne 0 ]
  then   
    echo -e "\n### Please input integer number! ###\n"
    exit 1
fi

###判断输入正整数大小
if [ $firstnum -eq $secondnum ];then
  echo "$firstnum equal $secondnum"
  exit 0
elif [ $firstnum -gt $secondnum ];then
  echo "$firstnum greater than $secondnum"
  exit 0
else
  echo "$firstnum less then $secondnum"
  exit 0
fi
    
