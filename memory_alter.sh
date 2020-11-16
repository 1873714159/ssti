#!/bin/bash

# Date: 2020-11-16
# Author: zoulongbin
# Description: Memory less than 100MB is alter and send email
# version: 1.0

freemen=`free | awk 'NR==3 {print $4}'`

if [ freemen -le 100000 ]
  then
    echo "oldboy" | mail-s "titile" oldoby@163.com
fi
