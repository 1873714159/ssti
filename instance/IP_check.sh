#!/bin/bash

# Date: 2020-11-20
# Author: zoulongbin
# Description: check IP survival
# Version: 1.0

. /etc/init.d/functions

ipinfo="/tmp/ip.log"

[ -f /tmp/ip.log ] && cat /dev/null > $ipinfo || touch $ipinfo

for i in {1..5}
do
   ping -c 2 10.10.10.$i > /dev/null 2>&1
   if [ $? -eq 0 ];then
      action "10.10.10.$i is ok" /bin/true | tee -a $ipinfo
   #   action "10.10.10.$i is ok" /bin/true >> $ipinfo
   else
      action "10.10.10.$i is false" /bin/false | tee -a $ipinfo
   #   action "10.10.10.$i is false" /bin/false >> $ipinfo
   fi
done
