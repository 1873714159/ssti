#!/bin/bash

# Date: 2020-11-16
# Author: zoulongbin
# Description: shell functions syntax
# Version: 1.0


###执行不带参数的函数时，直接输入函数名即可调用函数（注意：不带function和小括号）
###return命令与exit命令功能类似，return是退出当前函数体，exit是退出脚本文件

function name01() {
   echo "shell function syntax for example 01"
   return 1
}

function name02 {
   return 1
   echo "shell function syntax for example 02"
}

name03() {
   echo "shell function syntax for example 03"
}

name01
name02
name03
