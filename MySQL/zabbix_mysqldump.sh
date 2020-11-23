#!/bin/bash

# Date: 2020-11-20
# Author: zoulongbin
# Description: backup MySQL databases and exclude some history tables,for explamp history/thrends/alerts
# Version 1.0

# MySQL version : 5.7.32
# Shell Scripts Path: /data/scripts/zabbix_mysqldump.sh
# From : https://github.com/tmpyun/shellscripts.git
# Usage: chmod 700 ${MySQL_BACKUP_PATH/zabbix_mysqldump.sh}


. /etc/init.d/functions

source /etc/bashrc
source /etc/profile

MySQL_USER=root
MySQL_PASSWORD='#AAAaaa111#'
MySQL_HOST=localhost
MySQL_PORT=3306
MySQL_BACKUP_PATH=/data/mysql_backup
MySQL_BIN_PATH=/usr/bin/mysql
MySQL_DUMP_BIN_PATH=/usr/bin/mysqldump
MySQL_DATABASE_NAME=zabbix
DATE=$(date +%Y%m%d)

function MySQL_dump() {
   
   [ -d $MySQL_BACKUP_PATH ] || mkdir -p $MySQL_BACKUP_PATH
   [ -d ${MySQL_BACKUP_PATH}/logs ] || mkdir -p ${MySQL_BACKUP_PATH}/logs
   [ -d ${MySQL_BACKUP_PATH}/${DATE} ] || mkdir -p ${MySQL_BACKUP_PATH}/${DATE}
   
   cd ${MySQL_BACKUP_PATH}/${DATE}

    TABLE_NAME_ALL=$(${MySQL_BIN_PATH} -u${MySQL_USER} -p${MySQL_PASSWORD} -h${MySQL_HOST} ${MySQL_DATABASE_NAME} -e "show tables" | egrep -v "(Tables_in_zabbix|history*|trends*|acknowledges|alerts|auditlog|events|service_alarms)")
   
   for TABLE_NAME in ${TABLE_NAME_ALL}
   do
       ${MySQL_DUMP_BIN_PATH} -u${MySQL_USER} -p${MySQL_PASSWORD} -h${MySQL_HOST} --opt ${MySQL_DATABASE_NAME} ${TABLE_NAME} > ${MySQL_BACKUP_PATH}/${DATE}/${TABLE_NAME}.sql > /dev/null 2>&1
   done

  if [ $? -eq 0 ];then
     action "MySQL Backup successful" /bin/true
  else      
     action "MySQL Backup not successful" /bin/false
  fi

  cd $MySQL_BACKUP_PATH/
  if [ $? -eq 0 ];then
    find $MySQL_BACKUP_PATH -type d -name "*[0-9]" -mtime 7 -exec rm -rf {} \;
  fi
}

MySQL_dump
