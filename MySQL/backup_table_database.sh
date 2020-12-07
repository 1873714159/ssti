#!/bin/bash

# Date: 2020-12-07
# Author: zoulongbin
# Description: That backup single host  MySQL table databases
# Version: 1.0

# insert into /etc/my.cnf
# [mysql]
# user=root
# password=youpassword
# [mysqldump]
# user=root
# password=yourpassword

source /etc/profile
source /etc/bashrc


MySQL_mysql="/usr/bin/mysql"
MySQL_mysqldump="/usr/bin/mysqldump"
MySQL_backup_path="/data/test"
Date_name=$(date +%Y%m%d)

[ -d ${MySQL_backup_path} ] || mkdir -p ${MySQL_backup_path}
[ -f ${MySQL_mysql} -a -f ${MySQL_mysqldump} ] || {
  echo "That mysql or mysqldump command is not exist~!"
  exit 1
}

MySQL_databases=$(mysql -e "show databases;" | sed '1d' | egrep -v "information_schema|performance_schema|sys")
for dbname in ${MySQL_databases}
do
    mkdir -p ${MySQL_backup_path}/${Date_name}/${dbname}
 for dbtable in `mysql -e "show tables from ${dbname};" | sed '1d'`
 do 
    ${MySQL_mysqldump} ${dbname} ${dbtable} | gzip > ${MySQL_backup_path}/${Date_name}/${dbname}/${dbtable}_${Date_name}.sql.gz
 done
done

