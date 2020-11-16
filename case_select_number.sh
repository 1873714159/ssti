#!/bin/bash

# Date: 2020-11-16
# Author: zoulongbin
# Description: input 1-9 number and print
# Version: 1.0

read -p "Input [1-9] number: " num

[ -z $num ] && {
  echo -e "\n### Not null,Please input [1-9] number!"
  exit 1
}

expr $num + 1 > /dev/null 2>&1
[ $? -ne 0 ] && {
  echo -e "\n### Please input [1-9] number!"
  exit 1
}

case "$num" in
  1)
    echo "input number is $num"
    ;;
  2)
    echo "input number is $num"
    ;;
  [3-9])
    echo "input number is $num"
    ;;
  *)
    echo -e "\n### Please input [1-9] number ###\n"
    exit 1
esac
