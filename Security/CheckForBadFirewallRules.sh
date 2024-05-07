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

# Port 21 (FTP)
echo "Checking for overly permissive [${yellow}FTP${none}]/[${yellow}21{$none}] rules..."

# Firewalld
# Shorewall
# sudo cat /etc/shorewall/rules | grep...
# UFW
sudo ufw status 2> /dev/null | grep "21 " | grep "ALLOW" | grep "Anywhere"
sudo ufw status 2> /dev/null | grep "21/tcp " | grep "ALLOW" | grep "Anywhere"
sudo ufw status 2> /dev/null | grep "FTP " | grep "ALLOW" | grep "Anywhere"

echo ""

#//////////////////////////

# Port 22 (SSH/SFTP)
echo "Checking for overly permissive [${yellow}SSH${none}]/[${yellow}22${none}] rules..."

# Firewalld
# Shorewall
# sudo cat /etc/shorewall/rules | grep...
# UFW
sudo ufw status 2> /dev/null | grep "22 " | grep "ALLOW" | grep "Anywhere"
sudo ufw status 2> /dev/null | grep "22/tcp " | grep "ALLOW" | grep "Anywhere"
sudo ufw status 2> /dev/null | grep "SSH " | grep "ALLOW" | grep "Anywhere"

echo ""

#//////////////////////////

# Port 8443
echo "Checking for overly permissive [${yellow}8443${none}] rules..."

# Firewalld
# Shorewall
# sudo cat /etc/shorewall/rules | grep...
# UFW
sudo ufw status 2> /dev/null | grep "8443 " | grep "ALLOW" | grep "Anywhere"
sudo ufw status 2> /dev/null | grep "8443/tcp " | grep "ALLOW" | grep "Anywhere"

echo ""