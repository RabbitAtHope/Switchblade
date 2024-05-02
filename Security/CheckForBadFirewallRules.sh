#!/bin/bash

echo ""

#//////////////////////////

# Port 21 (FTP)
echo "Checking for overly permissive [FTP]/[21] rules..."

# Firewalld
# Shorewall
# sudo cat /etc/shorewall/rules | grep...
# UFW
sudo ufw status | grep "21 " 2> /dev/null | grep "ALLOW" | grep "Anywhere"
sudo ufw status | grep "21/tcp " 2> /dev/null | grep "ALLOW" | grep "Anywhere"
sudo ufw status | grep "FTP " 2> /dev/null | grep "ALLOW" | grep "Anywhere"

echo ""

#//////////////////////////

# Port 22 (SSH)
echo "Checking for overly permissive [SSH]/[22] rules..."

# Firewalld
# Shorewall
# sudo cat /etc/shorewall/rules | grep...
# UFW
sudo ufw status | grep "22 " 2> /dev/null | grep "ALLOW" | grep "Anywhere"
sudo ufw status | grep "22/tcp " 2> /dev/null | grep "ALLOW" | grep "Anywhere"
sudo ufw status | grep "SSH " 2> /dev/null | grep "ALLOW" | grep "Anywhere"

echo ""

#//////////////////////////