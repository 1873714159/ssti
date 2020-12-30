#!/bin/bash

# Date: 2020-12-30
# Author: zoulongbin
# Description: MySQL binary pack install
# Version: 1.0

###
# Warning:  MySQL binary pack must put same directory with scripts.
###


export PATH=$PATH
RED='\033[1;31;5m'
RES='\033[0m'
MYSQL_COUNT=$(netstat -tlunp | grep mysqld | wc -l)
MYSQL_PWD=$(pwd)
MYSQL_PACK="mysql-8.0.15-linux-glibc2.12-x86_64.tar.xz"
MYSQL_PATH="/usr/local/${MYSQL_PACK//-linux*/}"
MYSQL_LINK="/usr/local/mysql"


### check MySQL if installed
if [ $MYSQL_COUNT -ne 0 ];then
   echo -e "${RED} MySQL program is running ${RES}"
   exit 1
fi
### check MySQL directory is exits
if [ -d /usr/local/mysql* ];then 
   echo -e "${RED} MySQL directory is exits ${RES}"
   exit 1
fi

### install MySQL depend pack
yum -y install ncurses-devel libaio-devel gcc gcc++ > /dev/null 2>&1
if [ $? -ne 0 ];then
   echo -e "${RED} Yum install is failure,Please check network if surf the internet ${RES}"
   exit 1
fi

### discompress MySQL binary pack
tar xf ${MYSQL_PWD}/${MYSQL_PACK} -C /usr/local/
mv /usr/local/mysql-* ${MYSQL_PATH}
ln -s ${MYSQL_PATH} ${MYSQL_LINK}
mkdir -p ${MYSQL_LINK}/data
mkdir -p ${MYSQL_LINK}/logs


###judge my.cnf configuration file if exits
if [ -f /etc/my.cnf ];then
   mv /etc/my.cnf /tmp/
fi

### compile my.cnf configuration file
cat << EOF > /etc/my.cnf
[mysqld]

#server-id=1

mysqlx_socket=/tmp/mysqlx.sock
basedir=/usr/local/mysql
datadir=/usr/local/mysql/data
socket=/tmp/mysql.sock
pid-file=/tmp/mysqld.pid
log-error=/usr/local/mysql/logs/error.log

character-set-server=utf8mb4

max_connections=500
max_connect_errors=1000
port=3306
mysqlx_port=33060
EOF

### create MySQL virtual user
id mysql > /dev/null 2>&1
if [ $? -ne 0 ];then
  useradd -s /bin/nologin -M mysql
fi
### MySQL directory to mandate mysql user
chown -R mysql:mysql /usr/local/mysql*

### initialize MySQL
${MYSQL_LINK}/bin/mysqld --initialize --user=mysql --basedir=${MYSQL_LINK} --datadir=${MYSQL_LINK}/data

### copy MySQL boot scripts
cp ${MYSQL_LINK}/support-files/mysql.server /etc/init.d/mysqld
chmod +x /etc/init.d/mysqld
sed -i 's@^basedir=@basedir=/usr/local/mysql@g' /etc/init.d/mysqld
sed -i 's@^datadir=@datadir=/usr/local/mysql/data@g' /etc/init.d/mysqld

### MySQL take all command add system environment variable
echo 'export MYSQL_HOME=/usr/local/mysql' >> /etc/profile
echo 'export PATH=$PATH:${MYSQL_HOME}/bin' >> /etc/profile
source /etc/profile

### MySQL start
/etc/init.d/mysqld start > /dev/null 2>&1
if [ $? -ne 0 ];then
   echo -e "${RED} MySQL start is failure,Please check MySQL error-log ${RES}"
   exit 1
fi

### grep MySQL initialize root password and modify root password is 123456
MYSQL_PASS=$(grep "A temporary password" /usr/local/mysql/logs/error.log | awk '{print $NF}')
${MYSQL_LINK}/bin/mysql --connect-expired-password -uroot   -p${MYSQL_PASS}   -e  "alter user 'root'@'localhost' identified by '123456'"

### setup MySQL service auto start
cat << EOF >> /etc/rc.local
/etc/init.d/mysqld start
EOF
chmod +x /etc/rc.local

