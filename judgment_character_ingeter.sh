#!/bin/bash

# Date: 2020-11-16
# Author: zoulongbin
# Description: judgment character integer
# Version: 1.0

unset character01
unset character02

character01="123456"
character02="test123456"

echo -e "\n### NO 1"
###使用sed把一个字符串中的数字都替换成空，看被替换的字符串长度是否为0，0说明是整数，不为0说明不是整数
[ -n "`echo $character01 | sed 's/[0-9]//g'`" ] && echo "$character01 is not integer" || echo "$character01 is integer"
[ -n "`echo $character02 | sed 's/[0-9]//g'`" ] && echo "$character02 is not integer" || echo "$character02 is integer"

echo -e "\n### NO 2"
###使用变量的子串替换方法
[ -n "`echo "${character01//[0-9]/}"`" ] && echo "$character01 is not integer" || echo "$character01 is integer"
[ -n "`echo "${cahracter02//[0-9]/}"`" ] && echo "$character02 is not integer" || echo "$character02 is integer"

echo -e "\n### NO 3"
###使用expr判断
expr $character01 + 1 > /dev/null 2>&1
value01=$?
[ $value01 -ne 0 ] && echo "$character01 is not integer" || echo "$character01 is integer"

expr $character02 + 1 > /dev/null 2>&1
value02=$?
[ $value02 -ne 0 ] && echo "$character02 is not integer" || echo "$character02 is integer"

