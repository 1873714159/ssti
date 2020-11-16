#!/bin/bash

# Date: 2020-11-16
# Author: zoulongbin
# Description: judge url address
# Version: 1.0

. /etc/init.d/functions


function usage() {
  echo "Usage: $0 url"
  exit 1
}

function check_url() {
  curl -s -o /dev/null $1
  if [ $? -eq 0 ]
    then
      action "$1 is yes" /bin/true
  else
      action "$1 is no" /bin/false
  fi
}

function main() {
   if [ $# -eq 0 ]
     then
        usage
   fi

   check_url $1
}

main $*
