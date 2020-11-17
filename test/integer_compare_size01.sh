#!/bin/bash

# Date: 2020-11-13
# Author: zoulongbin
# Description: compare two integer size
# Version: 1.0

print_error01() { 
  echo -e "\n### Please input positive integer~! ###\n"
  exit 1
}

print_error02() {
  echo "### Not Null ，Please input positive integer~!###"
  exit 2
}

read -p "Please input first compare integer: " firstnum
read -p "Please input second compare integer: " secondnum

expr $firstnum + $secondnum + 1 > /dev/null 2>&1

[ -z "$firstnum" -o -z "$secondnum" ] && print_error02
[ -z "$firstnum" -a -z "$secondnum" ] && print_error02

[ $? -ne 0 ] && print_error01

[ $firstnum -eq $secondnum ] && echo "$firstnum equal $secondnum"

[ $firstnum -gt $secondnum ] && echo "$firstnum greater than $secondnum"

[ $firstnum -lt $secondnum ] && echo "$firstnum less than $secondnum"

