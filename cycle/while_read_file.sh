#!/bin/bash

# Date: 2020-11-17
# Author: zoulongbin
# Description: while read file /etc/passwd and print infomation
# Version: 1.0


###way 1
# exec < /etc/passwd

# while read line
# do
#    echo $line
# done


###way 2
# cat /etc/passwd | while read line
# do
#   echo $line
# done


###way 3
# while read line
# do
#   echo $line
# done < /etc/passwd
