#!/bin/bash

set -e 

# Date: 2020-11-11
# Author: zoulongbin
# Description: kill last scripts
# Version: 1.0

pidpath=/tmp/test.pid

if [ -f "${pidpath}" ]
 then
  kill `cat ${pidpath}` > /dev/null 2>&1
  rm -r ${pidpath}
fi

echo $$ > ${pidpath}

sleep 300
