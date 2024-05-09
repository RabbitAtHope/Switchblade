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
# HOSTNAME / DOMAIN NAME
#//////////////////////////

# Server hostname
hostname=$(hostname)
echo -e "[${yellow}Server Hostname${none}]: ${hostname}"

# Fully qualified domain name
fqdn=$(hostname -f)
echo -e "[${yellow}Fully Qualified Domain Name${none}]: ${fqdn}"

# DNS name
IP_ADDRESS=$(hostname -I | awk '{print $1}')
dnsname=$(nslookup $IP_ADDRESS | grep 'name =' | awk -F'=' '{print $2}' | sed 's/^\s*//g')
echo -e "[${yellow}DNS Name${none}]: ${dnsname}"

echo ""

#//////////////////////////
# NETWORK INFORMATION
#//////////////////////////

# Server IP address(es)
ipv4=$(ip -o -f inet addr show | awk '{print $4}' | grep -v '^127\.0\.0\.1/8$' | tr '\n' ', ' | sed 's/, $//')
# Remove the trailing comma
ipv4=${ipv4%,}
echo -e "[${yellow}IPv4 Addresses${none}]: ${ipv4}"

# OS details
os_details=$(lsb_release -a 2>/dev/null | grep Description | awk -F':' '{print $2}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
echo -e "[${yellow}Operating System${none}]: ${os_details}"

# Network interfaces
interfaces=$(ip link show | grep -Eo '^[0-9]+: [^:]+:' | awk '{print $2}' | tr '\n' ', ')
# Remove the trailing comma
interfaces=${interfaces%,}
echo -e "[${yellow}Network Interfaces${none}]: ${interfaces}"

echo ""

#//////////////////////////
# PACKAGE INFORMATION
#//////////////////////////

echo -e "[${yellow}Packages${none}]: Gathering package information..."

# APT

# Get a list of all installed packages and sort them alphabetically.
packages=$(apt list --installed 2>/dev/null | awk -F/ '{print $1}' | sort)

# Create a new array to store package names and their versions.
declare -A package_versions

# Loop through each package in the list to get its version.
# 'apt-cache policy' retrieves version information.
for package in $packages; do
    version=$(apt-cache policy "$package" | grep 'Installed' | awk '{print $2}')
    package_versions["$package"]="$version"
done

# DPKG

# YUM

#//////////////////////////
# DOCUMENTATION OUTPUT
#//////////////////////////

# - Mediawiki page
echo "" > MediawikiPage.txt # Create file and make sure it's empty
echo "'''${hostname} (${fqdn} / ${dnsname})''' is a '''${os_details}''' server. Its IP addresses are '''${ipv4}'''." >> MediawikiPage.txt
echo "" >> MediawikiPage.txt
echo "==Installed Packages==" >> MediawikiPage.txt
# -- Get sorted keys from the associative array
sorted_packages=($(for package in "${!package_versions[@]}"; do echo $package; done | sort))
# -- Append the package list in bullet-point format, sorted alphabetically, and categorize if possible
# --- Bind9 packages
echo "===Bind===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
	# Python
    if [[ "$package" =~ ^(bind9) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- OpenSSH
echo "===OpenSSH===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
	# Python
    if [[ "$package" =~ ^(openssh) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Python packages
echo "===Python===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
	# Python
    if [[ "$package" =~ ^(python|libpython) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Vim
echo "===Vim===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
	# Python
    if [[ "$package" =~ ^(vim) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- All other packages
echo "===Other===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(bind9|openssh|python|libpython|vim) ]]; then
        # Already added earlier, so do nothing
		:
	# Other
    else
        echo "- '''${package}''': ${package_versions[$package]}" >> MediawikiPage.txt
    fi
done
echo ""

#//////////////////////////

echo -e "[${green}Success${none}] Outputted wiki page contents."
echo -e " [${green}Mediawiki${none}]: MediawikiPage.txt"