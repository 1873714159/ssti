#!/bin/bash

# Date: 2020-11-17
# Author: zoulongbin
# Description: phone pay call charge
# Version: 1.0

unset sum
unset info
unset count

sum=100
info=15
count=1

function menu() {
  cat << EOF
==================
  1、充值
  2、发消息
  3、查看话费
  4、退出
==================
EOF
}


while true
do

menu
read -p  "Pleaser Select: " money
case "$money" in
  1)
     echo -e "\n"
     read -p "Please pay money: " paymoney
     echo $((sum=sum+${paymoney})) > /dev/null 2>&1
     echo -e "\n### 充值成功，当前话费 ${sum}元 ###\n"
  ;;
  2)
    echo -e "\n" 
    echo $((sum=sum-${info})) > /dev/null 2>&1
    echo -e "\n### 发送一条短，已扣${info}元 ###\n"
  ;;
  3)
    echo -e "\n### 你当前的话费剩余： ${sum}元 ###\n"
  ;;
  4)
    break
  ;;
  *)
    echo -e "\n### 请选择你要的服务项 ###\n"
esac

done

echo -e "\n### 欢迎下次光临~！###\n"

