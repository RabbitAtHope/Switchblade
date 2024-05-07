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

echo -e "[${green}Antivirus${none}] Checking for common [${green}antivirus${none}] services..."

# Avast
sudo systemctl status avast 2> /dev/null | grep -v "could not be found"
# ClamAV
sudo systemctl status clamav-daemon 2> /dev/null | grep -v "could not be found"
# Kaspersky Endpoint Security
sudo systemctl status klnagent 2> /dev/null | grep -v "could not be found"
# McAfee Endpoint Security
sudo systemctl status mfeespd 2> /dev/null | grep -v "could not be found"
# Sophos Anti-Virus
sudo systemctl status sav-protect 2> /dev/null | grep -v "could not be found"
# Symantec
sudo systemctl status sisamddaemon 2> /dev/null | grep -v "could not be found"
# Trend Micro
sudo systemctl status ds_agent 2> /dev/null | grep -v "could not be found"

echo ""

#//////////////////////////

echo -e "[${green}Endpoint Protection${none}] Checking for common [${green}EDR${none}] services..."

# Carbon Black
sudo systemctl status cbdaemon 2> /dev/null | grep -v "could not be found"
# CrowdStrike Falcon
sudo systemctl status falcon-sensor 2> /dev/null | grep -v "could not be found"
# FireEye Endpoint Security
sudo systemctl status xfe 2> /dev/null | grep -v "could not be found"
# Microsoft Defender ATP
sudo systemctl status mdatp 2> /dev/null | grep -v "could not be found"
# OsSec
sudo systemctl status ossec 2> /dev/null | grep -v "could not be found"
# SentinelOne
sudo systemctl status sentinel-agent 2> /dev/null | grep -v "could not be found"

echo ""

#//////////////////////////