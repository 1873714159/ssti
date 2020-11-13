#!/bin/bash


unset fstab
unset zabbixlog
unset testdir
unset passwd
unset shlink
unset motdsize

fstab="/etc/fstab"
zabbixlog="/etc/nfs.conf"
mntdir="/mnt"
testdir="/test"
passwd="/etc/passwd"
shlink="/bin/sh"
motdsize="/etc/motd"


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
