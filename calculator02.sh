#!/bin/bash

# Date: 2020-11-22
# Author: zoulongbin
# Description: + - * calculator
# Version: 2.0

print_usage() {
  echo -e "Please enter an integer\n"
  exit 1
}

read -p "Pleaser input first number: " firstnum
if [ -n "`echo ${firstnum} | sed 's/[0-9]//g'`" ];then
  print_usage
fi

read -p "Pleaser input operators: " operator
if [ "$operator" != "+" ] && [ "$operator" != "-" ] && [ "$operator" != "*" ];then
  echo "Please user {+|-|*}"
  exit 2
fi

read -p "Pleaser input second number: " secondnum
if [ -n "`echo ${secondnum} | sed 's/[0-9]//g'`" ];then
  print_usage
fi

echo "${firstnum} ${operator} ${secondnum} = $((${firstnum}${operator}${secondnum}))"
