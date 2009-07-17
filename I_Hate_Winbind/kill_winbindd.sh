#!/bin/bash

LIMIT=95
for CPU in $(/usr/bin/top -n 1 -b  | grep winbindd | grep -v grep | awk '{ print $9}')

do

       if (( ${CPU} > ${LIMIT} )); then
       echo "Killing WINBINDD"
       killall -9 /usr/sbin/winbindd
       killall -9 /usr/sbin/winbindd
       sleep 2
       echo "Restarting WINBINDD"
       /etc/init.d/winbind start
       exit
       fi


done
