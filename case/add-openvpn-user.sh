#!/bin/bash

# Date: 2020-11-17
# Author: zoulongbin
# Description: add user in /etc/openvpn_authfile.con
# Version: 1.0

. /etc/init.d/functions

function usage() {
    echo "sh `basename $0` {-add|-del|-search} username"
    exit 1
}


file_path=/etc/openvpn_authfile.conf

[ -f $file_path ] || touch $file_path

if [ $UID -ne 0 ]
  then
    echo "Your are not supper user,Please usage root!"
    exit 1
fi

if [ $# -ne 2 ]
  then
    usage
fi

case "$1" in
  -a|-add)
     shift
     if grep "^$1" ${file_path} > /dev/null 2>&1
       then
         action $"vpnuser,$1 is exist" /bin/false
         exit
     else
        chattr -i ${file_path}
        ##/bin/cp ${file_path} ${file_path}.$(date +%F%T)
        echo "$1" >> $file_path
        [ $? -eq 0 ]  && action $"Add $1" /bin/true
        chattr +i ${file_path}
     fi
   ;;
  -d|-del)
     shift
     if [ `grep "\b$1\b" ${file_path}|wc -l` -lt 1 ] 
       then
         action $"vpnuser,$1 is not exist." /bin/false
         exit
     else
         chattr -i ${file_path}
         ##/bin/cp ${FILE_PATH} ${FILE_PATH}.$(date +％F％T)
         sed -i "/^${1}$/d" ${file_path}
         [ $? -eq 0 ] && action $"Del $1" /bin/true
         chattr +i ${file_path} 
         exit
     fi
   ;;
   -s|-search)
      shift
      if [ `grep -w "$1" ${file_path}|wc -l` -lt 1 ]
        then
          echo $"vpnuser,$1 is not exist.";exit
      else
          echo $"vpnuser,$1 is exist.";exit
      fi
      ;;
    *)
        usage
        ;;
esac

