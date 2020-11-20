#!/bin/bash

# Date: 2020-11-20
# Author: zoulongbin
# Description: file fingerprint,if modify send email alarm
# Version: 1.0

retval=0
export LANG=en_US.UTF-8
check_dir=/var/html/www
error_log="/opt/error.log"
fingerprint="/opt/fingerprint.db"
filepath="/opt/filepath.db"
filepath_curr="/opt/filepath_curr.db"

[ -d /opt ] || mkdir -p /opt

[ -e $check_dir ] || {
   echo "$check_dir is not exist~!"
   exit 1
}


[ -f $fingerprint ] || {
   find $check_dir -type f | xargs md5sum > $fingerprint
   #echo "$fingerprint is no exist~! Please execution command : find $check_dir -type f | xargs md5sum > $fingerprint"
   #exit 1
}

[ -f $filepath ] || {
   find $check_dir -type f > $filepath
   #echo "$filepath is no exist~! Please execution command : find $check_dir -type f > $filepath"
   #exit 1
}


md5sum -c --quiet $fingerprint >> $error_log
retval=$?

find $check_dir -type f > $filepath_curr

diff $filepath $filepath_curr >> $error_log

if [ $retval -ne 0 -o `diff /opt/filepath.db /opt/filepath_curr.db|wc -l` -ne 0 ]
  then
    mail -s "`hostname` $(date +%F" "%T) error" zouh130326@hanslaser.com < $error_log
    sleep 1
else
   echo "$check_dir is ok" | mail -s "`hostname`  $(date +%F" "%T) is ok" zouh130326@hanslaser.com
fi

