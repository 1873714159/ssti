#!/bin/bash

# Date: 2020-11-23
# Author: zoulongbin
# Description: login system after prompt information
# Version: 1.0
# Permission: chmod 700 /etc/profile.d/SystemCheck.sh

### 字体颜色
RED='\E[1;31m'
RES='\E[0m'
FLASH='\E[05m'


### host infomation
loginhost=`hostname`
loginhostip=`ip a | egrep "eth0|ens192" | awk -F "[ /]+" 'NR==2 {print $3}'`
logintime=`date '+%Y-%m-%d %H:%m:%S'`
sysversion=`cat /etc/redhat-release | awk -F '[ ]+' '{print $4}'`

### CPU infomation
cputype=`cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq`
cpunumber=`lscpu | awk 'NR==8 {print $2}'`
cpupercore=`lscpu | awk 'NR==7 {print $4}'`
cpuload=`uptime | awk -F ":" '{print $NF}'`
sysruntime=`uptime | awk -F "[ ]+" '{print $4}'`
cpuload_prompt=($(uptime | awk -F ":" '{print $NF}'| tr -d ","))

### Memory infomation
memtoal=`free -h | awk -F "[: ]+" 'NR==2 {print $2}'`
memused=`free -h | awk -F "[: ]+" 'NR==2 {print $3}'`
memavailable=`free -h | awk -F "[: ]+" 'NR==2 {print $7}'`
memava_prompt=`free | awk -F "[: ]+" 'NR==2 {print $7}'`

### Disk infomation
disktotal=`df -h | grep -w '/' | awk '{print $2}'`
diskuserd=`df -h | grep -w '/' | awk '{print $3}'`
diskfree=`df -h | grep -w '/' | awk '{print $4}'`
diskper=`df -h | grep -w '/' | awk '{print $5}'`
rootdir_prompt=`df -h | grep -w '/' | awk '{print $5}' | tr -d "%"`
bootdir_prompt=`df -h | grep -w '/boot' | awk '{print $5}' | tr -d "%"`



function MemoryCheck() {

### Memory available less than 256M
if [ $memava_prompt -lt 256000 ]
  then
    echo -e "${FLASH} ${RED} *** Available Memory less than 256M *** ${RES}"
fi
 
}

function CPUCheck() {

### two core CPU
if [ $cpupercore -eq 2 ];then
 if [ `expr ${cpuload_prompt[0]} \> 3.0` -eq 1 ]
    then
      echo -e "${FLASH} ${RED} CPU one minute load greater than 3.0 ${RES}"
 elif [ `expr ${cpuload_prompt[1]} \> 2.0` -eq 1 ]
    then   
      echo -e "${FLASH} ${RED} CPU five minutes load greater than 2.0 ${RES}"
 elif [ `expr ${cpuload_prompt[2]} \> 2.0` -eq 1 ] 
    then
      echo -e "${FLASH} ${RED} CPU fifteen minutes load greater than 2.0 ${RES}"
 fi
### four core CPU
elif [ $cpupercore -eq 4 ];then
 if [ `expr ${cpuload_prompt[0]} \> 6.0` -eq 1 ]
    then
      echo -e "${FLASH} ${RED} CPU one minute load greater than 6.0 ${RES}"
 elif [ `expr ${cpuload_prompt[1]} \> 4.0` -eq 1 ]
    then   
      echo -e "${FLASH} ${RED} CPU five minutes load greater than 4.0 ${RES}"
 elif [ `expr ${cpuload_prompt[2]} \> 4.0` -eq 1 ] 
    then
      echo -e "${FLASH} ${RED} CPU fifteen minutes load greater than 4.0 ${RES}"
 fi
### eight core CPU
elif [ $cpupercore -eq 8 ];then
 if [ `expr ${cpuload_prompt[0]} \> 10.0` -eq 1 ]
    then
      echo -e "${FLASH} ${RED} CPU one minute load greater than 10.0 ${RES}"
 elif [ `expr ${cpuload_prompt[1]} \> 8.0` -eq 1 ]
    then   
      echo -e "${FLASH} ${RED} CPU five minutes load greater than 8.0 ${RES}"
 elif [ `expr ${cpuload_prompt[2]} \> 8.0` -eq 1 ] 
    then
      echo -e "${FLASH} ${RED} CPU fifteen minutes load greater than 8.0 ${RES}"
 fi
### sixteen core CPU
elif [ $cpupercore -eq 16 ];then
 if [ `expr ${cpuload_prompt[0]} \> 20.0` -eq 1 ]
    then
      echo -e "${FLASH} ${RED} CPU one minute load greater than 20.0 ${RES}"
 elif [ `expr ${cpuload_prompt[1]} \> 16.0` -eq 1 ]
    then   
      echo -e "${FLASH} ${RED} CPU five minutes load greater than 16.0 ${RES}"
 elif [ `expr ${cpuload_prompt[2]} \> 16.0` -eq 1 ] 
    then
      echo -e "${FLASH} ${RED} CPU fifteen minutes load greater than 16.0 ${RES}"
 fi
fi

}


function  DiskCheck() {

### root dir and boot dir percent greater than 90%
if [ $rootdir_prompt -gt 90 ]
  then 
    echo -e "${FLASH} ${RED} "/" root directory percent greater than 90% ${RES}"
elif [ $bootdir_prompt -gt 60 ]
  then
    echo -e "${FLASH} ${RED} "/" boot directory percent greater than 60% ${RES}"
fi

 
}


echo
echo "##############################################"
echo "### Login time:    ${logintime}"
echo "### Login host:    ${loginhost}"
echo "### Login IP:      ${loginhostip}"
echo "### sys version:   CentOS ${sysversion}"
echo "### sys runtime:   ${sysruntime} days"
echo "### scripts path:  /etc/profile.d/SystemCheck.sh"
echo "##############################################"
echo

echo "CPU型号:                " $cputype 
echo "CPU数量:                " $cpunumber
echo "CPU每个核数：           " $cpupercore
echo "CPU负载:                " $cpuload
CPUCheck
echo

echo "内存容量:               "  $memtoal
echo "内存已用:               "  $memused
echo "内存可用:               "  $memavailable
MemoryCheck
echo

echo "磁盘/根目录容量:        "  $disktotal
echo "磁盘/根目录已用:        "  $diskuserd
echo "磁盘/根目录可用:        "  $diskfree
echo "磁盘/根目录使用百分比:  "  $diskper
DiskCheck
echo
