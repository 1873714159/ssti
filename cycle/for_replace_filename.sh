#!/bin/bash

set -e 

# Date: 2020-11-12
# Author:zoulongbin
# Description: replace filename
# Version: 1.0


touch /tmp/stu_{10..15}_20201112_finished.jpg


echo -e "\n###Modify beforce###\n"
ls -l /tmp/*_finished.jpg

for i in `ls /tmp/*_finished.jpg`
do
  mv $i ${i//_finished/}
done

echo -e "\n###Modify After###\n"
ls -l /tmp/stu_*.jpg
