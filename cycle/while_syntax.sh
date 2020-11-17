#!/bin/bash

# Date: 2020-11-17
# Author: zoulongbin
# Description: while syntax
# Version: 1.0

###true 和 [ 1 ]功能相同，表示一直死循环（守护进程）
# while true
# do
#   uptime >> /tmp/log.txt
#   sleep 2
# done

# while [ 1 ]
# do
#    uptime
#    sleep
# done



###while当条件成立执行循环，不成立时跳出循环，until当条件不成立执行循环，成立跳出循环
# i=5
# while ((i>0))
# do
#   echo "$i"
#   ((i--))
# done

# y=5
# until [ $y -lt 1 ]
# do
#    echo "$y"
#    ((y--))
# done


###1+2+3....+100求和
# i=0
# sum=0

# while [ $i -le 100 ]
# do
#   ((sum+=$i))
#   ((i++))
# done
# echo $sum

# until [ $i -ge 101 ]
# do
#   ((sum+=$i))
#   ((i++))
# done
# echo $sum


###手机充话费一共1000元，每发一条短信就扣15元，当余额低于15元就提示费用不足够
i=15
y=1
sum=1000

while [ $sum -ge $i ]
do
  ((sum-=i))
  [ $sum -le $i ] && break
  echo "send $y message, left $sum"
  ((y++))
done
echo "your phone less equal $sum"

