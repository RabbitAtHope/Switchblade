#!/bin/bash

echo ""

#//////////////////////////

echo "Checking for common [antivirus] services..."

# Avast
sudo systemctl status avast 2> /dev/null
# ClamAV
sudo systemctl status clamav-daemon 2> /dev/null
# Kaspersky Endpoint Security
sudo systemctl status klnagent 2> /dev/null
# McAfee Endpoint Security
sudo systemctl status mfeespd 2> /dev/null
# Sophos Anti-Virus
sudo systemctl status sav-protect 2> /dev/null
# Symantec
sudo systemctl status sisamddaemon 2> /dev/null
# Trend Micro
sudo systemctl status ds_agent 2> /dev/null

echo ""

#//////////////////////////

echo "Checking for common [EDR] services..."

# Carbon Black
sudo systemctl status cbdaemon 2> /dev/null
# CrowdStrike Falcon
sudo systemctl status falcon-sensor 2> /dev/null
# FireEye Endpoint Security
sudo systemctl status xfe 2> /dev/null
# Microsoft Defender ATP
sudo systemctl status mdatp 2> /dev/null
# OsSec
sudo systemctl status ossec 2> /dev/null
# SentinelOne
sudo systemctl status sentinel-agent 2> /dev/null

echo ""

#//////////////////////////