#!/bin/bash

# Date:2020-11-19
# Author: zoulongbin
# Description: array cycle
# Version: 1.0

### print array per element
array01=(1 2 3 4 5 6)

for i in ${array01[*]}
do
   echo $i
done

echo -e "\n"



### print array per element
array02=(6 7 8 9 10)

for ((j=0;j<${#array02[*]};j++))
do
  echo ${array02[j]}
done

echo -e "\n"



### print array per element
array03=(11 12 13 14 15)
k=0
while ((k<${#array03[*]}))
do
   echo ${array03[k]}
   ((k++))
done

echo -e "\n"


### print /etc/passwd per low
userinfo=($(cat /etc/passwd | head -n 3))

for ((f=0;f<${#userinfo[*]};f++))
do
    echo "The $f user information is { ${userinfo[f]} }"
done

echo -e "\n"


### print array element pcs less than 3
array04=(I am a good engineer)

for ((k=0;k<${#array04[*]};k++))
do
   if [ ${#array04[$k]} -lt 3 ]
     then
        echo ${array04[$k]}
   fi
done

echo -e "\n"

array05=(I am a good engineer)
for h in ${array05[*]}
do
   if [ `expr length $h` -gt 3 ]
      then
        echo $h
   fi
done

echo -e "\n"

array06=(This is test array)
echo ${array06[*]} | awk '{for(n=1;n<=NF;n++) if(length($n)<=4) print $n}'






