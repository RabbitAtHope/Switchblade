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

# Server hostname
hostname=$(hostname)
echo -e "[${yellow}Server Hostname${none}]: ${hostname}"

#//////////////////////////

# Fully qualified domain name
fqdn=$(hostname -f)
echo -e "[${yellow}Fully Qualified Domain Name${none}]: ${fqdn}"

#//////////////////////////

# Server IP address(es)
ipv4=$(ip -o -f inet addr show | awk '{print $4}' | tr '\n' ', ' | sed 's/, $//')
echo -e "[${yellow}IPv4 Addresses${none}]: ${ipv4}"

# OS details
os_details=$(lsb_release -a 2>/dev/null | grep Description | awk -F':' '{print $2}' | sed 's/^ *//')
echo -e "[${yellow}Operating System${none}]: ${os_details}"

# Network interfaces
interfaces=$(ip link show | grep -Eo '^[0-9]+: [^:]+:' | awk '{print $2}' | tr '\n' ', ')
# Remove the trailing comma
interfaces=${interfaces%,}
echo -e "[${yellow}Network Interfaces${none}]: ${interfaces}"

echo ""

#//////////////////////////

# - Mediawiki page
echo "'''${hostname} (${fqdn})''' is a ${os_details} server. Its IP addresses are '''${ipv4}'''.\n" > MediawikiPage.txt

echo ""

#//////////////////////////

echo -e "[${green}Success${none}] Outputted wiki page contents."