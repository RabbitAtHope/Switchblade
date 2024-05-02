#!/bin/bash

echo ""

#//////////////////////////

# Port 21 (FTP)
echo "Checking for overly permissive [FTP]/[21] rules..."

# Firewalld
# Shorewall
# sudo cat /etc/shorewall/rules | grep...
# UFW
sudo ufw status 2> /dev/null | grep "21 " | grep "ALLOW" | grep "Anywhere"
sudo ufw status 2> /dev/null | grep "21/tcp " | grep "ALLOW" | grep "Anywhere"
sudo ufw status 2> /dev/null | grep "FTP " | grep "ALLOW" | grep "Anywhere"

echo ""

#//////////////////////////

# Port 22 (SSH)
echo "Checking for overly permissive [SSH]/[22] rules..."

# Firewalld
# Shorewall
# sudo cat /etc/shorewall/rules | grep...
# UFW
sudo ufw status 2> /dev/null | grep "22 " | grep "ALLOW" | grep "Anywhere"
sudo ufw status 2> /dev/null | grep "22/tcp " | grep "ALLOW" | grep "Anywhere"
sudo ufw status 2> /dev/null | grep "SSH " | grep "ALLOW" | grep "Anywhere"

echo ""

#//////////////////////////