#!/bin/bash

# Date: 2020-11-18
# Author: zoulongbin
# Description: create 3 user and set random password
# version: 1.0

. /etc/init.d/functions


passwdfile="/tmp/passwd.log"

for i in `seq -w 03`
do

   userpasswd=`echo $RANDOM | md5sum | cut -c 1-5`    
   useradd test$i > /dev/null 2>&1
   if [ $? -eq 0 ];then
      echo $userpasswd | passwd --stdin test$i > /dev/null 2>&1
      echo -e "\n### user: test$i\tpasswd: ${userpasswd} ###\n" >> $passwdfile
      action "create test$i user is successful~!" /bin/true
   else
      action "test$i user is exist~!" /bin/false
   fi
done
