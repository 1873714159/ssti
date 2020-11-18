#!/bin/bash

# Date: 2020-11-18
# Author: zoulongbin
# Description: for cycle syntax
# Version: 1.0


###print 1 2 3 
#for i in `seq 3`
#do
#  echo $i
#done 
#
#for i in {1..3}
#do
#  echo $i
#done
#
#for i in 1 2 3
#do
#  echo $i
#done


###count 1+2+3+4....+10
#for ((i=1;i<=10;i++))
#do
#   ((sum+=$i))
#done
#echo $sum

#for i in {1..10}
#do
#   ((sum+=$i))
#done
#echo $sum


###replace filename
#for i in `ls /tmp/stu*`
#do
#   mv $i ${i//_finished/}
#done
#
#for i in `ls /tmp/stu*`
#do
#   mv $i `echo $i | sed 's/_finished//g'`
#done


