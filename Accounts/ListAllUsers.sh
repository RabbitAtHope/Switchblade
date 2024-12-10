#!/bin/bash

# Pretty colors.
red='\033[0;31m'
green='\033[0;32m'
orange='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
lightgray='\033[0;37m'
darkgray='\033[1;30m'
lightred='\033[1;31m'
lightgreen='\033[1;32m'
yellow='\033[1;33m'
lightblue='\033[1;34m'
lightpurple='\033[1;35m'
lightcyan='\033[1;36m'
white='\033[1;37m'
none='\033[0m'

echo ""

#//////////////////////////

echo -e "[${green}Users${none}] that can be logged into on this machine:"

sudo cat /etc/passwd | grep -v "/nologin" | sort

echo ""

#//////////////////////////

echo -e "[${green}Users${none}] that can be logged into with [${red}shell access${none}]:"

sudo cat /etc/passwd | grep -v "/nologin" | grep "/bin/bash" | sort

echo ""

#//////////////////////////

echo -e "[${green}Users${none}] that have logged in before:"

sudo lastlog | grep -v Never

echo ""