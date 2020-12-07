#!/bin/bash

# Date: 2020-12-07
# Author: zoulongbin
# Description: That backup single host MySQL all databases
# Version：1.0

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
source /etc/profile
source /etc/bashrc

MySQL_USER="root"
MySQL_PASSWORD="123456"
MySQL_mysqldump="/usr/bin/mysqldump"
MySQL_mysql="/usr/bin/mysql"
MySQL_BACKUP_PATH="/data/MySQL"
Email_NAME='123456@qq.com'
DATE_NAME=$(date +%Y%m%d)

[ -d /data/MySQL ] || mkdir -p /data/MySQL
[ -f $MySQL_mysqldump -a -f $MySQL_mysql ] || { 
  echo "mysqldump or mysql command is not exist~!"
  exit 1
}

### Judge MySQL user or password whether right
${MySQL_mysql} -u${MySQL_USER} -p${MySQL_PASSWORD} -e "show databases;" > /dev/null 2>&1
[ $? -ne 0 ] && {
  echo "User or Password is error~!"
  exit 1
}

$MySQL_mysqldump -u$MySQL_USER -p$MySQL_PASSWORD -B -A --master-data=2 --single-transaction --flush-logs --triggers --routines --events --hex-blob | gzip > ${MySQL_BACKUP_PATH}/mysqlbak_${DATE_NAME}.sql.gz
mysqlcheck=$?

sleep 2

md5sum ${MySQL_BACKUP_PATH}/mysqlbak_${DATE_NAME}.sql.gz > ${MySQL_BACKUP_PATH}/${DATE_NAME}_md5.flag
md5sumcheck=$?

find ${MySQL_BACKUP_PATH}/ -type f -name "*.sql.gz" -mtime +7 | xargs rm -rf
deletecheck=$?

find ${MySQL_BACKUP_PATH}/ -type f -name "*.flag" -mtime +7 | xargs rm -rf

if [ $mysqlcheck -eq 0 -a $md5sumcheck -eq 0 -a $deletecheck -eq 0 ];then
  if [ -f ${MySQL_BACKUP_PATH}/mysqlbak_${DATE_NAME}.sql.gz ];then
    echo -e "\n MySQL backup file infomation:\n$(ls -lrth /data/MySQL/*) \n\n MySQL backup file md5sum: \n$(md5sum -c ${MySQL_BACKUP_PATH}/${DATE_NAME}_md5.flag)" > /tmp/mysql_backup_log.txt
    mail -s "MySQL backup is successful at ${DATE_NAME}" ${Email_NAME}  < /tmp/mysql_backup_log.txt
  else
     echo "\n MySQL backup error~! Please Check! \n" | mail -s "MySQL backup error at ${DATE_NAME}" ${Email_NAME}
  fi 
fi
