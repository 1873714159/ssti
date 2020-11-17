#!/bin/bash

# Date:2020-11-17
# Author: zoulongbin
# Description: Apache access.log monitoring IP connections greater than 10 , use iptables disable IP
# Version: 1.0

function usage() {
   echo -e "\n### Usage: sh `basename $0` /var/log/httpd/access.log ###\n"
   exit 1
}

file=$1

[ $# -ne 1 ] && usage

while true
do
  ###需要排除10.10.10.1 apache服务器本身IP
  awk '{print $1}' $1 | egrep -vw "^$|10.10.10.1" | sort -r | uniq -c > /tmp/tmp.log
  exec < /tmp/tmp.log
  
  while read line
  do
    ip=`echo $line | awk '{print $2}'`
    count=`echo $line | awk '{print $1}'`
    firewallcount=`iptables -L -n | grep "$ip" | wc -l`

    if [ $count -gt 10 -a $firewallcount -lt 1 ]
      then
        iptables -I INPUT -s $ip -j DROP
        echo "$line is dropped" >> /tmp/droplist_$(date +%Y%m%d).log
    fi
  done
     sleep 60
done
