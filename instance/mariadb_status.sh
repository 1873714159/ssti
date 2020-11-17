#!/bin/bash

# Date: 2020-11-16
# Author: zoulongbin
# Description: judgment mariadb status,if mariadb status is shutdown open mariadb service
# Version: 1.0

unset portnum
unset telnetnum
unset pidnum

###通过端口判断
portnum=`ss -tlunp | grep 3306 | wc -l`

###通过telnet服务检测服务端口是否畅通判断
telnetnum=`echo -e "\n"|telnet 127.0.0.1 3306 2>/dev/null|grep Connected|wc -l`

###通过mariadb数据库生成的pid文件判断，mariadb启动会生成pid文件，如果停止pid文件会消失，所以，只判断pid文件存不存在即可
pidnum="/var/run/mariadb/mariadb.pid"


if [ $portnum -eq 0 ]
  then
    systemctl start mariadb
    echo -e "\n### Mariadb is Starting...... ###\n"
    sleep 10
else
    echo -e "\n### Mariadb is status normal ###\n"
fi
