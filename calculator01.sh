#!/bin/bash

# Date: 2020-11-12
# Author: zoulongbin
# Description: + - * calculator
# Version: 1.0

print_usage() {
  echo -e "Please enter integer\n"
  exit 1
}

read -p "Please input first number: " firstnum

[ ${#firstnum} -le 0 ] && {
  echo "The first number is not null"
  exit 1
}

read -p "Please input second number: " secondnum

[ ${#secondnum} -le 0 ] && {
  echo "Then second number is not null"
  exit 1
}

expr $firstnum + 1 > /dev/null 2>&1 && [ $? -eq 0 ] || print_usage

expr $secondnum + 1 > /dev/null 2>&1 && [ $? -eq 0 ] || print_usage


echo "$firstnum + $secondnum = $(($firstnum+$secondnum))"
