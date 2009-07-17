#!/bin/bash
#
#simple wrapper for mysql that runs mysqldump as root, adds drop table statements and backups all databases.
#It then uses find to delte database backups older $maxfileage (in days)
name=$(hostname)
d=$(date +%F)
dir="/home/ken/mysqlbackup"
file="mysqlbackup-"$name"-"$d
mysqldump="/usr/bin/mysqldump -u root --add-drop-table --allow-keywords --all-databases"
maxfileage=7


if [ ! -d "$dir" ];then

mkdir -p $dir

fi

cd $dir

if [ ! -d "$d" ]; then mkdir $d
fi

$mysqldump > $d/$file

gzip -f $d/$file

cd $dir

if [ $? -ne 0 ];then
	echo "couldn't find mysql backup dir, don't want to accidentally delete anything!"
	exit
else
        find $dir/2* -mtime +${maxfileage} -type d -exec rm -rf {} \;
        

fi
