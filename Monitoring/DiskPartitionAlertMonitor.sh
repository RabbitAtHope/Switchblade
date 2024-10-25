#!/bin/sh
# Purpose: Monitor Linux disk space on a specific partition, and send an email alert to $ADMIN if it reaches a certain threshold.
ALERT=85 # alert level 
ADMIN="email@example.com"
DISKNAME="diskname"
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | grep $DISKNAME | awk '{ print $5 " " $1 }' | while read -r output;
do
  echo "$output"
  usep=$(echo "$output" | awk '{ print $1}' | cut -d'%' -f1 )
  partition=$(echo "$output" | awk '{ print $2 }' )
  if [ $usep -ge $ALERT ]; then
    echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" |
    mail -s "Disk Space Alert: $(hostname)" "$ADMIN"
  fi
done
