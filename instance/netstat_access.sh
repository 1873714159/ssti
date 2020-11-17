#!/bin/bash

# Date: 2020-11-17
# Author: zoulongbin
# Description: netstat command monitoring IP connections greater than 10 , use iptables disable IP
# Version: 1.0

[ -f /tmp/test.log ] && mv /tmp/test.log /tmp/test.log.bak

while true
do

  netstat -an | grep -w "ESTABLISHED" | grep -vw "10.10.10.1" | awk -F "[ :]+" '{print $6}' | sort -r | uniq -c > /tmp/test.log
  
  exec < /tmp/test.log

  while read line
  do
    ip=`echo $line | awk '{print $2}'`
    count=`echo $line | awk '{print $1}'`
    firewallcount=`iptables -L -n | grep "$ip" | wc -l`

    if [ $count -gt 5 -a $firewallcount -lt 1 ]
      then
        iptables -I INPUT -s $ip -j DROP
        echo "$line is dropped" >> /tmp/droplist_$(date +%Y%m%d).log
    fi
  done
     sleep 5
done
