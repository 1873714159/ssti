#!/bin/bash

# Date: 2020-12-07
# Author: zoulongbin
# Description: That backup single host MySQL all databases at everyday,but everyweek to cover
# Version：1.0

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
source /etc/profile
source /etc/bashrc

MySQL_mysqldump="/usr/bin/mysqldump"
MySQL_mysql="/usr/bin/mysql"
Comm_find="/usr/bin/find"
MySQL_BACKUP_PATH="/data/MySQL/database"
DATE_NAME=$(date +%Y%m%d)

[ -d ${MySQL_BACKUP_PATH} ] || mkdir -p ${MySQL_BACKUP_PATH}
[ -f $MySQL_mysqldump -a -f $MySQL_mysql ] || { 
  echo "mysqldump or mysql command is not exist~!"
  exit 1
}

### Judge MySQL user or password whether right
${MySQL_mysql} -e "show databases;" > /dev/null 2>&1
[ $? -ne 0 ] && {
  echo "User or Password is error~!"
  exit 1
}

${MySQL_mysqldump} --all-databases --flush-privileges --single-transaction --triggers --routines --events --hex-blob | gzip > ${MySQL_BACKUP_PATH}/mysql_bak_${DATE_NAME}.sql.gz

sleep 2

${Comm_find} ${MySQL_BACKUP_PATH}/ -type f -name "mysql_bak*.sql.gz" -mtime +6 | xargs rm -rf

