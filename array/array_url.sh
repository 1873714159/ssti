#!/bin/bash


# Date: 2020-11-19
# Author: zoulongbin
# Description: check URL,if URL is unachievable prompt
# Version: 1.0


. /etc/init.d/functions

url=(
https://www.jd.com
https://www.baidu.com
https://3434dsferwerewr.com
https://www.hao123.com
)


function main() {

for ((i=0;i<${#url[*]};i++))
do
    curl -s -o /dev/null ${url[$i]}
    if [ $? -eq 0 ]
       then
         action "This is ${url[$i]} is ok" /bin/true
    else
         action "This is ${url[$i]} is error" /bin/false
    fi
done

}

function waits() {

  for ((i=0;i<5;i++))
  do
     echo -n ".";sleep 1
  done
    echo
}

j=1
while true
do
   echo -e "\n### The $j time print ###\n"
   main
   echo -n "###5秒后，执行检查URL操作" 
   waits
   ((j++))
done
