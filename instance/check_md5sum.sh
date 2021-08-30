#!/bin/bash

# Author: zoulongbin
# Date: 2021-08-31
# Description: Backuping file and check md5sum

source /etc/profile
dirdate=$(date '+%F %H:%M')


### single backup file check md5sum
rsync -avP /mnt/bak.tar.gz root@10.10.10.20:/opt/dhg_mysql/

md5sum01=`md5sum /mnt/bak.tar.gz | awk '{print \$1}'`
md5sum02=$(ssh 10.10.10.20 "md5sum /opt/dhg_mysql/bak.tar.gz | awk '{print \$1}'")

if [ ${md5sum01} == ${md5sum02} ];then
   echo "${dirdate} /opt/bak.tar.gz remote backup successful!" >> /mnt/validate.txt
else 
   echo "${dirdate} /opt/bak.tar.gz remote backup Failed!" >> /mnt/validate.txt
   mail -s MySQL_Backup 123456@qq.com < /mnt/validate.txt
fi




### multiple backup file check md5sum
md5sum /mnt/* > /mnt/md5.txt

scp -rp /mnt/* root@10.10.10.20:/mnt > /dev/null 2>&1

checkmd5=$(ssh 10.10.10.20 "md5sum -c --status /mnt/md5.txt";echo $?)

if [ ${checkmd5} -eq 0 ];then 
   echo "${dirdate} /mnt/ directory all file remote backup successful!" >> /mnt/validate.txt
else
   echo "${dirdate} /mnt/ directory one of file remote backup failed!" >> /mnt/validate.txt
   mail -s MySQL_Backup 123456@qq.com < /mnt/validate.txt
fi

