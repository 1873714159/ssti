#!/bin/bash

# Date: 2020-11-16
# Author: zoulongbin
# Description: input content select add color
# Version: 1.0

unset red
unset green
unset yellow
unset blue
unset pink
unset res

red='\E[1;31m'
green='\E[1;32m'
yellow='\E[1;33m'
blue='\E[1;34m'
pink='\E[1;35m'
res='\E[0m'

function print_usage() {
    echo -e "\n### Usage $0 content {red|yellow|blue|pink} ###\n"
    exit 1
}

function selectcolor() {
 
if [ $# -ne 2 ]
  then
    print_usage
fi

case "$2" in
  red|RED)
    echo -e "${red}$1${res}"
    ;;
  yellow|YELLOW)
    echo -e "${yellow}$1${res}"
    ;;
  green|GREEN)
    echo -e "${green}$1${res}"
    ;;
  blue|BLUE)
    echo -e "${blue}$1${res}"
    ;;
  pink|PINK)
    echo -e "${pink}$1${res}"
    ;;
  *)
    print_usage
esac
}

function main() {
  selectcolor $1 $2
}


###main $* 等同 main $1 $2
main $*



