#!/bin/bash

# Date: 2020-11-18
# Author: zoulongbin
# Description: select syntax
# Version: 1.0

### syntax 1
# select name in xiaoming xiaohong xiaozhang
# do
#   echo $name
# done


### syntax 2
# array=(xiaoming xiaohong xiaozhang)
# 
# select name in "${array[@]}"
# do
#   echo $name
# done


### syntax 3
PS3="Please select a num from menu: "

select name in xiaoming xiaohong xiaozhang
do
  echo -e "You select the menu is : $REPLY $name"
done
