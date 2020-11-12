#!/bin/bash

# Date: 2020-11-12
# Author: zoulongbin
# Description: calculate string length less equal 2
# version: 1.0

oldboy="I am oldboy linux welcome to our traning"

for i in $oldboy
do
  if [ `expr length $i` -le 2 ];then
    echo $i
  fi
done
