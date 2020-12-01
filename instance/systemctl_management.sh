#!/bin/bash


# Date:2020-12-01
# Author: zoulongbin
# Description: management systemctl
# Version: 1.0


[ -f /usr/bin/systemctl ] || echo "System version is not CentOS 7 above~!"


function Usage() {
  echo -e "\n ### Please select option {1|2|3|4|5} ### \n"
}

function SelectMenu() {
cat << EOF   
1、all running service
2、all enabled service
3、all disabled service
4、select stop service
5、exit

EOF
}


function SelectRunning() {
array=(`systemctl --type=service --state=running | grep -w "running" | awk '{print $1}'| tr '\n' ' '`) 
for ((i=0;i<${#array[*]};i++))
do
  echo "$i   ${array[$i]}"
done
}



function main() {

array[0]="all_running_service"
array[1]="all_enabled_service"
array[2]="all_disabled_ervice"
array[3]="select_disabled_service"
array[4]="exit"

PS3="Please select service: "

select select in ${array[*]}
do
case $REPLY in
  1)
   echo -e "\n##############\n"
   systemctl --type=service --state=running | grep -w "running"
   echo -e "\n##############\n"
   SelectMenu
   ;;
  2)
   echo -e "\n##############\n"
   systemctl list-unit-files | grep -w "enabled"
   echo -e "\n##############\n"
   SelectMenu
   ;;
  3) 
   echo -e "\n##############\n"
   systemctl list-unit-files | grep -w "disabled"
   echo -e "\n##############\n"
   SelectMenu
   ;;
  4)
   echo -e "\n##############\n"
   SelectRunning
   echo -e "\n##############\n"
   read -p "Please select stop service serial number：" sernum01
   echo -e "\n##############\n"
   
   expr $sernum01 + 1 > /dev/null 2>&1
   [ $? -ne 0 ] && {
     echo -e "\n *** Please input service serial number *** \n"
     exit 1
   }
   for ((j=0;j<${#array[*]};j++))
   do
     if [ $sernum01 -eq $j ];then
        systemctl stop ${array[$j]}
     fi
   done
   SelectMenu
   ;; 
  5)
   exit 0
   ;;
  *)
   Usage 
esac
done
}

main
