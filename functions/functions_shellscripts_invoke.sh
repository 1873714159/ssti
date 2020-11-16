#!/bin/bash

# Date: 2020-11-16
# Author: zoulongbin
# Description: functions invoke shellscripts
# Version: 1.0


[ -f /data/shellscripts/functions/shell_functions_syntax.sh ] && . /data/shellscripts/functions/shell_functions_syntax.sh || exit 1

name04 xiaoming

name04 $1
