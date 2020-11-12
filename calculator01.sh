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
read -p "Please input second number: " secondnum

expr $firstnum + 1 > /dev/null 2>&1 && [ $? -eq 0 ] || print_usage
expr $secondnum + 1 > /dev/null 2>&1 && [ $? -eq 0 ] || print_usage

echo "$firstnum + $secondnum = $(($firstnum+$secondnum))"
