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

#////////////////////////////////////////////////////#
# SUCCESSFUL LOGINS: Fetch all successes and sort them into categories.
#////////////////////////////////////////////////////#

echo -e "[${green}Successes${none}] Fetching all [successful recent logins]..."

# Get all recent logins and the IP addresses they came from.
sudo cat /var/log/auth.log 2> /dev/null | grep "Accepted password" | sort

echo ""

#////////////////////////////////////////////////////#
# FAILED LOGINS: Fetch all failures and sort them into categories.
#////////////////////////////////////////////////////#

echo -e "[${red}Failures${none}] Fetching recent [${red}failed attempts${none}] to [${green}existing accounts${none}] that aren't [${yellow}root${none}]..."

# Get all recent failed login attempts to accounts that exist.
sudo cat /var/log/auth.log 2> /dev/null | grep "Failed password for" | grep -v "Failed password for invalid user" | grep -v "Failed password for root" | sort

echo ""

#//////////////////////////

echo -e "[${red}Failures${none}] Fetching recent [${red}failed attempts${none}] to [${red}nonexistent accounts${none}], which are likely brute force attempts..."

# Get all recent failed login attempts to accounts that DON'T exist.
sudo cat /var/log/auth.log 2> /dev/null | grep "Failed password for invalid user" | sort

echo ""

#//////////////////////////

echo -e "[${red}Failures${none}] Fetching recent [${red}failed attempts${none}] to log into [${yellow}root${none}], which are likely malicious attempts..."

# Get all recent failed login attempts to the root account.
sudo cat /var/log/auth.log 2> /dev/null | grep "Failed password for root" | sort

echo ""

#//////////////////////////