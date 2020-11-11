#!/bin/bash

set -e

# Date: 2020-11-11
# Author: zoulongbin
# Description: This scripts function is clean /var/log/messages
# Version: 1.0


LOG_DIR=/var/log
ROOT_UID=0

if [ "$UID" -ne "$ROOT_UID" ]
then
 echo "Must be root to run this scripts"
 exit 1
fi

cd $LOG_DIR || {
 echo "Cannot change to necessary directory"
 exit 1
}

cat /dev/null > messages && {
 echo "Logs cleaned up"
 exit 0
}

echo "Logs cleaned up fail"
exit 1
