#!/bin/bash

# Date: 2020-11-23
# Author: zoulongbin
# Description: login system after prompt information
# Version: 1.0
# Permission: chmod 700 /etc/profile.d/SystemCheck.sh
# System: fit CentOS 6 above version


### 字体颜色
RED='\033[1;31m'
YELLOW='\033[1;33m'
REDFLASH='\033[1;31;5m'
YELLOWFLASH='\033[1;33;5m'
RES='\033[0m'


### host infomation
loginhost=`hostname`
loginhostip=`ip a | egrep "eth0|ens192" | awk -F "[ /]+" 'NR==2 {print $3}'`
logintime=`date '+%Y-%m-%d %H:%m:%S'`
sysver=`cat /etc/redhat-release | sed 's/[a-zA-Z ()]//g'`
sysver_judge=`cat /etc/redhat-release | sed 's/[a-zA-Z ()]//g' | awk -F "[.]" '{print $1}'`

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
memavailable_6=`free | awk 'NR==2 {print (($4+$5+$6+$7))/1024"MB"}' | sed 's/\.[0-9]*//g'`
memava_prompt_6=`free | awk 'NR==2 {print (($4+$5+$6+$7))}'`
memavailable_7=`free -h | awk -F "[: ]+" 'NR==2 {print $7}'`
memava_prompt_7=`free | awk -F "[: ]+" 'NR==2 {print $7}'`

### Disk infomation
disktotal=`df -h | grep -w '/' | awk '{print $2}'`
diskuserd=`df -h | grep -w '/' | awk '{print $3}'`
diskfree=`df -h | grep -w '/' | awk '{print $4}'`
diskper=`df -h | grep -w '/' | awk '{print $5}'`
rootdir_prompt=`df -h | grep -w '/' | awk '{print $5}' | tr -d "%"`
bootdir_prompt=`df -h | grep -w '/boot' | awk '{print $5}' | tr -d "%"`

### security infomation
iptables_status=`/etc/init.d/iptables status | wc -l`
firewall_status=`systemctl status firewalld | awk 'NR==3 {print $2}'`
selinux_status=`getenforce`


function MemoryCheck() {

### Memory available less than 256M
if [ $sysver_judge -eq 6 ];then
  [ $memava_prompt_6 -lt 256000 ]  && echo -e "${YELLOWFLASH} *** Available Memory less than 256M *** ${RES}"
elif [ $sysver_judge -eq 7 ];then
  [ $memava_prompt_7 -lt 256000 ]  && echo -e "${YELLOWFLASH} *** Available Memory less than 256M *** ${RES}"
fi
}


function CPUCheck() {

### two core CPU
if [ $cpupercore -eq 2 ];then
[ `expr ${cpuload_prompt[0]} \> 3.0` -eq 1 ] && echo -e "${YELLOWFLASH} *** CPU one minute load greater than 3.0 *** ${RES}"
[ `expr ${cpuload_prompt[1]} \> 2.0` -eq 1 ] &&  echo -e "${REDFLASH} *** CPU five minutes load greater than 2.0 *** ${RES}"
[ `expr ${cpuload_prompt[2]} \> 2.0` -eq 1 ] && echo -e "${REDFLASH} *** CPU fifteen minutes load greater than 2.0 *** ${RES}"
### four core CPU
elif [ $cpupercore -eq 4 ];then
[ `expr ${cpuload_prompt[0]} \> 6.0` -eq 1 ] && echo -e "${YELLOWFLASH} *** CPU one minute load greater than 6.0 *** ${RES}"
[ `expr ${cpuload_prompt[1]} \> 4.0` -eq 1 ] &&  echo -e "${REDFLASH} *** CPU five minutes load greater than 4.0 *** ${RES}"
[ `expr ${cpuload_prompt[2]} \> 4.0` -eq 1 ] && echo -e "${REDFLASH} *** CPU fifteen minutes load greater than 4.0 *** ${RES}"
### eight core CPU
elif [ $cpupercore -eq 8 ];then
[ `expr ${cpuload_prompt[0]} \> 10.0` -eq 1 ] && echo -e "${YELLOWFLASH} *** CPU one minute load greater than 10.0 *** ${RES}"
[ `expr ${cpuload_prompt[1]} \> 8.0` -eq 1 ] &&  echo -e "${REDFLASH} *** CPU five minutes load greater than 8.0 *** ${RES}"
[ `expr ${cpuload_prompt[2]} \> 8.0` -eq 1 ] && echo -e "${REDFLASH} *** CPU fifteen minutes load greater than 8.0 *** ${RES}"
### sixteen core CPU
elif [ $cpupercore -eq 16 ];then
[ `expr ${cpuload_prompt[0]} \> 18.0` -eq 1 ] && echo -e "${YELLOWFLASH} *** CPU one minute load greater than 18.0 *** ${RES}"
[ `expr ${cpuload_prompt[1]} \> 16.0` -eq 1 ] &&  echo -e "${REDFLASH} *** CPU five minutes load greater than 16.0 *** ${RES}"
[ `expr ${cpuload_prompt[2]} \> 16.0` -eq 1 ] && echo -e "${REDFLASH} *** CPU fifteen minutes load greater than 16.0 *** ${RES}"
fi

}


function  DiskCheck() {

## root dir and boot dir percent greater than 90%
[ $rootdir_prompt -gt 90 ] && echo -e "${REDFLASH} "/" root directory percent greater than 90% ${RES}"
[ $bootdir_prompt -gt 60 ] && echo -e "${REDFLASH} "/" boot directory percent greater than 60% ${RES}"
 
}


function judge_iptables() {

### judge system version running check iptables status
if [ $sysver_judge -eq 6 ];then
  [ $iptables_status -gt 1 ] && echo "iptables 状态:          "  running || echo "iptables 状态:          "  not running
elif [ $sysver_judge -eq 7 ];then
  echo "iptables 状态:          "  $firewall_status
fi

}


function judge_sysversion() {

### judge system version
if [ $sysver_judge -eq 6 ];then
  echo "### sys version:   CentOS ${sysver}"
elif [ $sysver_judge -eq 7 ];then
  echo "### sys version:   CentOS ${sysver}"
fi

}


function judge_printmemava() {

### judge system version print memory available
if [ $sysver_judge -eq 6 ];then
   echo "内存可用:               "  $memavailable_6
elif [ $sysver_judge -eq 7 ];then
   echo "内存可用:               "  $memavailable_7
fi

}


echo
echo "##############################################"
echo "### Login time:    ${logintime}"
echo "### Login host:    ${loginhost}"
echo "### Login IP:      ${loginhostip}"
judge_sysversion
echo "### sys runtime:   ${sysruntime} days"
echo "### scripts path:  /etc/profile.d/SystemCheck.sh"
echo -e "### ${RED}红色消息(严重)${RES}     ${YELLOW}黄色消息(警告)${RES}"
echo "##############################################"
echo -e "\n\n"

echo "CPU型号:                " $cputype 
echo "CPU数量:                " $cpunumber
echo "CPU每个核数：           " $cpupercore
echo "CPU平均负载:            " $cpuload
CPUCheck
echo -e "\n\n"

echo "内存容量:               "  $memtoal
echo "内存已用:               "  $memused
judge_printmemava
MemoryCheck
echo -e "\n\n"

echo "磁盘/根目录容量:        "  $disktotal
echo "磁盘/根目录已用:        "  $diskuserd
echo "磁盘/根目录可用:        "  $diskfree
echo "磁盘/根目录使用百分比:  "  $diskper
DiskCheck
echo -e "\n\n"

judge_iptables
echo "SElinux  状态:          "  $selinux_status
echo -e "\n\n"

