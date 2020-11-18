#!/bin/bash

# Date: 2020-11-18
# Author: zoulongbin
# Description: select install service
# Version: 1.0


retvar=0

path=/data/scripts

[ -d $path ] || mkdir -p /data/scripts

function Usage() {
   echo "Usage: $0 {ssh|ftp|nginx|exits}"
   return 1
}

function InstallService() {
   if [ $# -ne 1 ];then
     Usage
   fi

   local retvar=0

   if [ ! -f ${path}/${1}.sh ];then
      echo "${path}/${1}.sh does not exist~!"
      return 1
   elif [ ! -x ${path}/${1}.sh ];then
      echo "${path}/${1}.sh does not exec permission~!"
      return 1
   else
     echo "start installing $1"
     $path/${1}.sh
     sleep 2
     return $retvar
   fi
}

function main() {

   PS3="Please select install service: "
   
   select var in "ssh" "ftp" "nginx" "exits"
   do
       case "$REPLY" in
       1)
          InstallService ssh
          retvar=$
          ;;
       2)
          InstallService ftp
          retvar=$
          ;;
       3)
          InstallService nginx
          retvar=$
          ;;
       4)
          return 0
          ;;
       5)
          usage
       esac
   done
}

main


