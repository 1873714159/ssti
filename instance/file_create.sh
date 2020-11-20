#!/bin/bash

# Date: 2020-11-20
# Author: zoulongbin
# Description: batch create random filename 10 file and include "_testfile.html" string filename
# Version: 1.0

. /etc/init.d/functions


[ -d /dirtest ] || mkdir -p /dirtest

for i in `seq 10`
do
   filename=`openssl rand -base64 40 | sed 's/[^a-z]//g' | cut -c 1-6`
   touch /oldboy/${filename}_testfile.html > /dev/null 2>&1
   if [ $? -eq 0 ];then
     action "create ${filename}_testfile.html" /bin/true
   else
     action "${filename}_testfile.html is exist~!" /bin/false
   fi
done

echo -e "\n#####"

ls -l /oldboy/*_testfile.html
