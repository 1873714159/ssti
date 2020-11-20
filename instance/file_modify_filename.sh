#!/bin/bash 

# Date: 2020-11-20
# Author: zoulongbin
# Description: batch modify filename
# Version: 1.0

. /etc/init.d/functions


[ ! -d /dirtest ] && mkdir -p /dirtest


echo -e "\n#### create file ###\n"

### create 10 file
for i in {10..20}
do
  touch /dirtest/stu_${i}_testfile.txt
  action "create stu_${i}_testfile.txt create successful" /bin/true
done


echo -e "\n#### Modify filename ###\n"

### modify 10 filename

for j in `ls /dirtest/*_testfile.txt`
do
   mv $j ${j//_testfile/_finished}
   action "$j modify successful" /bin/true
done
