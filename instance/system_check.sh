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
GREEN='\033[1;32m'
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
root_disktotal=`df -h | grep -w '/' | awk '{print $2}'`
root_diskuserd=`df -h | grep -w '/' | awk '{print $3}'`
root_diskfree=`df -h | grep -w '/' | awk '{print $4}'`
root_diskper=`df -h | grep -w '/' | awk '{print $5}'`
boot_disktotal=`df -h | grep -w '/boot' | awk '{print $2}'`
boot_diskuserd=`df -h | grep -w '/boot' | awk '{print $3}'`
boot_diskfree=`df -h | grep -w '/boot' | awk '{print $4}'`
boot_diskper=`df -h | grep -w '/boot' | awk '{print $5}'`
rootdir_prompt=`df -h | grep -w '/' | awk '{print $5}' | tr -d "%"`
bootdir_prompt=`df -h | grep -w '/boot' | awk '{print $5}' | tr -d "%"`

### security infomation
selinux_status=`getenforce`
max_user_processes=`ulimit -u`
tcp_connection_num=`netstat -an | egrep "^tcp|^udp" | wc -l`



###### ****** 报警函数 ****** ######

function Memory_alert() {
  ### Memory available less than 256M
  if [ $sysver_judge -eq 6 ];then
    [ $memava_prompt_6 -lt 256000 ]  && echo -e "${YELLOWFLASH} *** Available Memory less than 256M *** ${RES}"
  elif [ $sysver_judge -eq 7 ];then
    [ $memava_prompt_7 -lt 256000 ]  && echo -e "${YELLOWFLASH} *** Available Memory less than 256M *** ${RES}"
  fi
}

function CPU_alert() {
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

function  Disk_alert() {
  ### root dir and boot dir percent greater than 90%
  [ $rootdir_prompt -gt 90 ] && echo -e "${REDFLASH} "/" root directory percent greater than 90% ${RES}"
  [ $bootdir_prompt -gt 60 ] && echo -e "${REDFLASH} "/" boot directory percent greater than 60% ${RES}"
}

function Security_alert() {
  ### user maxmum processes less than 1024 
  [ $max_user_processes -lt 1024 ] && echo -e "${YELLOWFLASH} *** user maxmum processes less than 1024 ${RES}"
  [ $tcp_connection_num -gt 1024 ] && echo -e "${YELLOWFLASH} *** tcp connection number greater than 1024 ${RES}"
}



###### ****** 系统分辨函数 ****** ######

function iptables_judge() {
  ### judge system version running check iptables status
  if [ $sysver_judge -eq 6 ];then
    iptables_status=`/etc/init.d/iptables status | wc -l`
    [ $iptables_status -gt 1 ] && echo -e "iptables 状态:           ${GREEN}running${RES} "|| echo -e "iptables 状态:           ${GREEN}not running${RES}"
  elif [ $sysver_judge -eq 7 ];then
    firewall_status=`systemctl status firewalld | awk 'NR==3 {print $2}'`
    echo -e "iptables 状态:           ${GREEN}${firewall_status}${RES}"
  fi
}

function sysversion_judge() {
  ### judge system version
  if [ $sysver_judge -eq 6 ];then
    echo "### sys version:   CentOS ${sysver}"
  elif [ $sysver_judge -eq 7 ];then
    echo "### sys version:   CentOS ${sysver}"
  fi
}

function printmemava_judge() {
  ### judge system version print memory available
  if [ $sysver_judge -eq 6 ];then
     echo -e "内存可用:                ${GREEN}${memavailable_6}${RES}"
  elif [ $sysver_judge -eq 7 ];then
     echo -e "内存可用:                ${GREEN}${memavailable_7}${RES} "
  fi
}



###### ****** 显示函数 ****** ######

### CPU 显示模块
function CPU_print() {
  echo -e "CPU型号:                ${GREEN}${cputype}${RES}" 
  echo -e "CPU数量:                 ${GREEN}${cpunumber}${RES}"
  echo -e "CPU每个核数：            ${GREEN}${cpupercore}${RES}"
  echo -e "CPU平均负载:            ${GREEN}$cpuload${RES}"
}

### Memory 显示模块
function Memory_print() {
  echo -e "内存容量:                ${GREEN}${memtoal}${RES}"
  echo -e "内存已用:                ${GREEN}${memused}${RES}"
  printmemava_judge
}

### root directory 显示模块
function Disk_root_print() {
  echo -e "/根目录容量:             ${GREEN}${root_disktotal}${RES}"
  echo -e "/根目录已用:             ${GREEN}${root_diskuserd}${RES}"
  echo -e "/根目录可用:             ${GREEN}${root_diskfree}${RES}"
  echo -e "/根目录使用百分比:       ${GREEN}${root_diskper}${RES}"
}

### boot directory 显示模块
function Disk_boot_print() {
  echo -e "/boot目录容量:           ${GREEN}$boot_disktotal${RES}"
  echo -e "/boot目录已用:           ${GREEN}${boot_diskuserd}${RES}"
  echo -e "/boot目录可用:           ${GREEN}${boot_diskfree}${RES}"
  echo -e "/boot目录使用百分比:     ${GREEN}${boot_diskper}${RES}"
}


### Security 显示模块
function Security_print() {
  iptables_judge
  echo -e "SElinux  状态:           ${GREEN}${selinux_status}${RES}"
  echo -e "用户最大进程连接数限制:  ${GREEN}${max_user_processes}${RES}"
  echo -e "当前TCP连接数:           ${GREEN}${tcp_connection_num}${RES}"
}



###### ****** 主程序 ****** ######

echo
echo "#################################################"
echo "### Login time:    ${logintime}"
echo "### Login host:    ${loginhost}"
echo "### Login IP:      ${loginhostip}"
sysversion_judge
echo "### sys runtime:   ${sysruntime} days"
echo "### scripts path:  /etc/profile.d/SystemCheck.sh"
echo -e "### ${RED}红色消息(严重)${RES}     ${YELLOW}黄色消息(警告)${RES}"
echo "#################################################"
echo -e "\n"

CPU_print
CPU_alert
echo -e "\n"

Memory_print
Memory_alert
echo -e "\n"

Disk_root_print
echo
Disk_boot_print
Disk_alert
echo -e "\n"

Security_print
Security_alert
echo -e "\n"

