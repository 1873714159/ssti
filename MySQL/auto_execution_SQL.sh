#!/bin/bash

# Date: 2020-12-16
# Author: zoulongbin
# Description:  MySQL create/insert  option in scription
# Versoin: 1.0

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin

user="root"
pass="123456"

mysql -u$user -p$pass << EOF > /dev/null 2>&1
create database student;
EOF
[ $? -eq 0 ] && echo "create database student is sucessful~!" || echo "create database student is failed~!"

mysql -u$user -p$pass << EOF > /dev/null 2>&1
use student;
create table student01 (
id int null
);
EOF
[ $? -eq 0 ] && echo "create table student01 is sucessful~!" ||  echo "create table student01 is failed~!"

mysql -u$user -p$pass << EOF > /dev/null 2>&1
use student;
insert into student01(id) values('1'),('2'),('3');
EOF
[ $? -eq 0 ] && echo "insert into student01 is sucessful~!" || echo "insert into student01 is failed~!"

mysql -u$user -p$pass -e "
show databases;
use student;
show tables;
desc student01;
"
