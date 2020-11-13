#!/bin/bash

unset fstab
unset zabbixlog
unset testdir
unset passwd
unset shlink
unset motdsize
unset string01
unset string02
unset string03
unset string04

fstab="/etc/fstab"
zabbixlog="/etc/nfs.conf"
mntdir="/mnt"
testdir="/test"
passwd="/etc/passwd"
shlink="/bin/sh"
motdsize="/etc/motd"
string01="test"
string02=""
string03="test"
string04="file"


###文件测试操作符
echo -e "\n*** test equal [  ] or [[  ]] ,for example : test -f $fstab equal [ -f $fstab ] or [[ -f $fstab ]] ***\n"

echo -e "\n### test -d (directory) ###"
test -d $mntdir && echo "`file $mntdir` Exist" || echo "`file $mntdir` Not Exist"
test -d $testdir && echo "`file $testdir` Exist" || echo "`file $testdir` Not Exist"

echo -e "\n### test -f (file) ###"
test -f $fstab && echo "`file $fstab` Exist" || echo "`file` $fstab Not Exist"
test -f $zabbixlog && echo "`file $zabbixlog` Exist" || echo "`file $zabbixlog` Not Exist"

echo -e "\n###test -r (read) ###"
test -r $fstab && echo "`ls -l $fstab | awk '{print $1,$9}'` Read" || echo "`ls -l $fstab | awk '{print $1,$9}'`Not Read" 
test -r $mntdir && echo "`ls -ld $mntdir | awk '{print $1,$9}'` Read" || echo "`ls -ld $mntdir | awk '{print $1,$9}'` Not Read" 

echo -e "\n###test -w (write)###"
test -w $passwd && echo "`ls -l $passwd | awk '{print $1,$9}'` Write" || echo "`ls -l $passwd | awk '{print $1,$9}'` Not Write" 
test -w $mntdir && echo "`ls -ld $mntdir | awk '{print $1,$9}'` Write" || echo "`ls -ld $mntdir | awk '{print $1,$9}'` Not Write" 

echo -e "\n###test -x (executable) ###"
test -x $passwd && echo "`ls -l $passwd | awk '{print $1,$9}'` Executable" || echo "`ls -l $passwd | awk '{print $1,$9}'` Not Executable" 
test -x $mntdir && echo "`ls -ld $mntdir | awk '{print $1,$9}'` Executable" || echo "`ls -ld $mntdir | awk '{print $1,$9}'` Not Executable" 

echo -e "\n###test -L (link) ###"
test -L $shlink && echo "`ls -l $shlink | awk '{print $1,$9}'` Link File" || echo "`ls -l $shlink | awk '{print $1,$9}'` Not Link File" 

echo -e "\n###test -s (size) ###"
test -s $motdsize && echo "`ls -l $motdsize` Not Size 0" || echo "`ls -l $motdsize` szie 0" 

echo -e "\n###test file1 -nt (new than,modify time) file2  ###"
test $fstab -nt $passwd && echo "$fstab new than $passwd" || echo "$passwd new than $fstab" 

echo -e "\n###test file1 -ot (old than,modify time) file2  ###"
test $fstab -ot $passwd && echo "$fstab old than $passwd" || echo "$passwd old than $fstab"



###特殊条件表达式
echo -e "\n\n*** test or [  ] or [[  ]] variable not can add double quotation(""),if not test result maybe false ***"
[ -f "$fstab" ] && echo "`file $fstab` Exist" || echo "`file` $fstab Not Exist"
[ -f $fstab ] && echo "`file $fstab` Exist" || echo "`file` $fstab Not Exist"



###字符串操作符
echo -e "\n\n*** string test operation , munt string add double quotation(""), equal both sides add space***"

echo -e "\n### test -n "string" (no zero is true,if not false)"
[ -n "$string01" ] && echo "$string01 no zeor" || echo "$string01 zeor"

echo -e "\n### test -z "string" (zero is true,if not false)"
[ -z "$string02" ] && { 
  echo "$string02 zeor" 
} || {
  echo "$string02 not zeor"
}

echo -e "\n### test "string" = "string" or "string" == "string" (equal is true,if not false)"
[ "$string01" = "$string03" ] && echo "$string01 equal $string03" || echo "$String01 not equal $string03"
[ "$string01" == "$string04" ] && echo "$string01 equal $string04" || echo "$string01 not equal $string04"

echo -e "\n### test "string" != "string" (no equal is true,if not false)"
[ "$string01" != "$string04" ] && echo "$string01 not equal $string04" || "$string01 equal $string04"



###整数比较操作符
echo -e "\n\n*** integer than operation"

echo -e "\n### test -eq or [ -eq ] (equal) \t### (( =/== )) or [[ =/== ]] (equal)"
[ 2 -eq 2 ] && echo "2 equal 2" 

echo -e "\n### test -ne or [ -ne ] (not equal) \t### (( != )) or [[ != ]] (not equal)"
[ 3 -eq 4 ] && echo "3 not equal 4"

echo -e "\n### test -gt or [ -gt ] (greater than) \t### (( > )) or [[ > ]] (greater than)"
[ 3 -gt 2 ] && echo "3 greater than 2"

echo -e "\n### test -ge or [ -ge ] (greater equal) \t### (( >= )) or [[ >= ]] (greater equal)"
[ 3 -ge 3 ] && echo "3 greater equal 3"

echo -e "\n### test -lt or [ -lt ] (less than) \t### (( < )) or [[ < ]] (less than)"
[ 3 -lt 6 ] && echo "3 less than 6"

echo -e "\n### test -le or [ -le ](less equal) \t### (( <= )) or [[ <= ]] ((less equal))"
[ 3 -le 3 ] && echo "3 less equal 3"



###逻辑操作符
echo -e "\n\n*** logic operation"

echo -e "\n### test -a or [ -a ] (and) \t### (( && )) or [[ && ]] (and)"
[ -f $fstab -a -f $passwd ] && echo "$fstab and $passwd is exist" || {
echo "$fstab or $passwd is not exist"
echo "$fstab and $passwd is not exist"
}
echo -e "\n### test -o or [ -a ] (or) \t### (( || )) or [[ || ]] (or)"
[ -f $fstab -o -f $passwd ] && echo "$fstab or $passwd is exist" || echo "$fstab and $passwd is not exist"

echo -e "\n### test ! or [ ! ] (not) \t### (( ! )) or [[ ! ]] (not)"
[ ! -n $fstab ] && echo "$fstab is zero" || echo "$fstab is no zero"



###通配符匹配场景
echo -e "\n\n*** wildcards match"

echo -e "\n### wildchards match use [[  ]], not can use [  ]"
[[ "abc123" == abc1* ]] && echo "abc123 equal abc1*" || echo "abc123 not equal abc1*"
[[ "abcdef" == ab*f ]] && echo "abcdef equal ab*f" || echo "abcdef not equal ab*f"


