#!/bin/bash

# Date: 2020-11-12
# Author: zoulongbin
# Description: calculate string length less equal 2
# version: 1.0

unset character01
unset character02
unset character03

character01="test123456"
character02=""
character03="I am oldboy linux welcome to our traning"

echo -e "\n### NO 1"
###判断每个字符串长度小于2
for i in $character03
do
  if [ `expr length $i` -le 2 ];then
    echo $i
  fi
done

echo -e "\n### NO 2"
###使用test条件表达式-z或-n判断字符串长度是否为0
[ -z "$character01" ] && echo "Variable \$character01 is null" || echo "Variable \$character01 is not null"
[ -n "$character02" ] && echo "variable \$character02 is not null" || echo "Variable \$character02 is null"

echo -e "\n### No3"
###使用变量子串判断
[ ${#character01} -eq 0 ] && echo "Variable \$character01 is null" || echo "Variable \$character01 is not null"
[ ${#character02} -ne 0 ] && echo "Variable \$character01 is not null" || echo "Variable \$character01 is null"

echo -e "\n### NO 4"
###使用expr length函数判断
[ `expr length ${character01}` -eq 0 ] && echo "Variable \$character01 is null" || echo "Variable \$charachter01 is not null"

echo -e "\n### NO 5"
###使用wc -L 统计字符判断
[ `echo $character01 | wc -L` -eq 0 ] && echo "Variable \$charachter01 is null" || echo "Variabel \$charachter01 is not null"

echo -e "\n### NO 6"
###使用awk length 函数判断
[ `echo $character01 | awk '{print length}'` -eq 0 ] && echo "Variable \$charachter01 is null" || echo "Variabel \$charachter01 is not null"
