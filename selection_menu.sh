#!/bin/bash

# Date: 2020-11-13
# Author: zoulongbin
# Description: print menu
# Version: 1.0


path="/data/scripts"
[ ! -d $path ] && mkdir -p /data/scripts

cat << EOF 
  1.ssh
  2.ftp
  3.nginx
EOF

read -p "Please selection: " num

###judgment integer
expr $num  + 1 > /dev/null 2>&1
[ $? -ne 0 ] && {
   echo "Please input integer (1|2|3)"
   exit 1
}

###judgment not null
[ -z $num ] && {
  echo "Not Null,Pleaser input integer (1|2|3)"
  exit 1
}

###selection 1
[ $num -eq 1 ] && {
  echo "start instll ssh"
  sleep 2;
  [ -x $path/ssh.sh ] || {
     echo "$path/ssh.sh does not exist or can not be execution"
     exit 1
  }
  
  sh $path/ssh.sh
  exit $?
}

###selection 2
[ $num -eq 1 ] && {
  echo "start instll ftp"
  sleep 2;
  [ -x $path/ssh.sh ] || {
     echo "$path/ftp.sh does not exist or can not be execution"
     exit 1
  }
  
  sh $path/ftp.sh
  exit $?
}

###selection 3
[ $num -eq 1 ] && {
  echo "start instll nginx"
  sleep 2;
  [ -x $path/ssh.sh ] || {
     echo "$path/nginx.sh does not exist or can not be execution"
     exit 1
  }
  
  sh $path/nginx.sh
  exit $?
}

###anyother selection
[[ ! $num = ~[1-3] ]] && {
  echo "Please input integer (1|2|3)"
  exit 1
}
