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
dnsname=${dnsname%.} # Remove period at end
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
packages=$(apt list --installed 2>/dev/null | grep -v 'Listing...' | awk -F/ '{print $1}' | sort)

# Create a new array to store package names and their versions.
declare -A package_versions

echo -e "[${yellow}Packages${none}]: Getting package versions..."

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

echo -e "[${yellow}Output${none}]: Writing to file..."

# - Mediawiki page
echo "" > MediawikiPage.txt # Create file and make sure it's empty
echo "'''${hostname} (${fqdn} / ${dnsname})''' is a '''${os_details}''' server. Its IP addresses are '''${ipv4}'''." >> MediawikiPage.txt
echo "" >> MediawikiPage.txt
echo "==Installed Packages==" >> MediawikiPage.txt
# -- Get sorted keys from the associative array
sorted_packages=($(for package in "${!package_versions[@]}"; do echo $package; done | sort))
# -- Append the package list in bullet-point format, sorted alphabetically, and categorize if possible
# --- Linux kernel / packages
echo "===Linux===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(linux) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Acl
echo "===Acl===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(acl|libacl) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Adduser
echo "===Adduser===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(adduser) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Algorithm
echo "===Algorithm===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(algorithm|libalgorithm) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Alpine
echo "===Alpine===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(alpine|libalpine) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Amd
echo "===Amd===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(amd|libamd) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Apache
echo "===Apache===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(apache|libapache) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Apparmor
echo "===Apparmor===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(apparmor|libapparmor) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Apport
echo "===Apport===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(apport) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Apt
echo "===Apt===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(apt|libapt) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Bash
echo "===Bash===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(bash) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Bind
echo "===Bind===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(bind9) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Binutils
echo "===Binutils===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(binutils|libbinutils) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Blockdev
echo "===Blockdev===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(blockdev|libblockdev) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Bolt
echo "===Bolt===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(bolt) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Busybox
echo "===Busybox===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(busybox) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Byobu
echo "===Byobu===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(byobu) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Bzip
echo "===Bzip===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(bzip|libbzip) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Certbot
echo "===Certbot===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(certbot) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Class
echo "===Class===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(class|libclass) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Cpp
echo "===Cpp===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(cpp|libcpp) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Cron
echo "===Cron===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(cron) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Cryptsetup
echo "===Cryptsetup===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(cryptsetup|libcryptsetup) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Curl
echo "===Curl===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(curl|libcurl) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Dash
echo "===Dash===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(dash|libdash) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Datetime
echo "===Datetime===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(datetime|libdatetime) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Dbus
echo "===Dbus===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(dbus) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Dpkg
echo "===Dpkg===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(dpkg) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Eject
echo "===Eject===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(eject) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Ethtool
echo "===Ethtool===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(ethtool) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Fakeroot
echo "===Fakeroot===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(fakeroot) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Falcon-sensor
echo "===Falcon-sensor===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(falcon\-sensor) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Fdisk
echo "===Fdisk===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(fdisk|libfdisk) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- File
echo "===File===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(file) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Fonts
echo "===Fonts===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(fonts) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- G++
echo "===G++===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(g\+\+|libg\+\+) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Gawk
echo "===Gawk===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(gawk|libgawk) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Gcc
echo "===Gcc===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(gcc|libgcc) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Git
echo "===Git===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(git) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Gpg
echo "===Gpg===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(gpg|libgpg) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Grep
echo "===Grep===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(grep) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Grub
echo "===Grub===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(grub) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Gzip
echo "===Gzip===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(gzip) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Hostname
echo "===Hostname===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(hostname) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Htop
echo "===Htop===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(htop) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Init
echo "===Init===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(init) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Iproute
echo "===Iproute===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(iproute) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Iptables
echo "===Iptables===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(iptables) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Iputils
echo "===Iputils===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(iputils) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- MariaDB
echo "===MariaDB===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(mariadb) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- MySQL
echo "===MySQL===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(mysql) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Ncurses
echo "===Ncurses===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libncurses|ncurses) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Netcat
echo "===Netcat===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(netcat) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Netplan
echo "===Netplan===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libnetplan|netplan) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Ntp
echo "===Ntp===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libntp|ntp) ]]; then
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
    if [[ "$package" =~ ^(libopenssh|openssh) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Pam
echo "===Pam===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libpam|pam) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Parted
echo "===Parted===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libparted|parted) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Passwd
echo "===Passwd===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libpasswd|passwd) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Perl
echo "===Perl===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libperl|perl) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Php
echo "===Php===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libphp|php) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Plymouth
echo "===Plymouth===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libplymouth|plymouth) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Polkit
echo "===Polkit===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libpolkit|polkit) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Pollinate
echo "===Pollinate===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(pollinate) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Postfix
echo "===Postfix===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libpostfix|postfix) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Python
echo "===Python===" >> MediawikiPage.txt
# ---- Python 2
echo "====Python 2====" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libpython2|python2) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
# ---- Python 3
echo "====Python 3====" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libpython3|python3) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
# ---- Python other
echo "====Other Python packages====" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libpython2|python2) ]]; then
        # Do nothing
		:
    elif [[ "$package" =~ ^(libpython3|python3) ]]; then
        # Do nothing
		:
    elif [[ "$package" =~ ^(libpython|python) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Rsync
echo "===Rsync===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(rsync) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Samba
echo "===Samba===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(samba) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Screen
echo "===Screen===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(screen) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Sed
echo "===Sed===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(sed) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Sendemail
echo "===Sendemail===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(sendemail) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Sg3
echo "===Sg3===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(sg3) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Sosreport
echo "===Sosreport===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(sosreport) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Sudo
echo "===Sudo===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(sudo) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Systemd
echo "===Systemd===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libsystemd|systemd) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Tar
echo "===Tar===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libtar|tar) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Tcl
echo "===Tcl===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libtcl|tcl) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Tcpdump
echo "===Tcpdump===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(tcpdump) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Telnet
echo "===Telnet===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(telnet) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Thermald
echo "===Thermald===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(thermald) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Time
echo "===Time===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(time) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Tmpreaper
echo "===Tmpreaper===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(tmpreaper) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Tss
echo "===Tss===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libtss|tss) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Ubuntu
echo "===Ubuntu===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(ubuntu) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Ucf
echo "===Ucf===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(ucf) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Udev
echo "===Udev===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(udev) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Ufw
echo "===Ufw===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(ufw) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Unzip
echo "===Unzip===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(unzip) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Usb
echo "===Usb===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libusb|usb) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Usrmerge
echo "===Usrmerge===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(usrmerge) ]]; then
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
    if [[ "$package" =~ ^(libvim|vim) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Webmin
echo "===Webmin===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(webmin) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Wget
echo "===Wget===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libwget|wget) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Whiptail
echo "===Whiptail===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(whiptail) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Xauth
echo "===Xauth===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libxauth|xauth) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Xkb
echo "===Xkb===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libxkb|xkb) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Xml
echo "===Xml===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libxml|xml) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Xxd
echo "===Xxd===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libxxd|xxd) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Xymon
echo "===Xymon===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libxymon|xymon) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Xz
echo "===Xz===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libxz|xz) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Yaml
echo "===Yaml===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libyaml|yaml) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Yp-tools
echo "===Yp-tools===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(yp\-tools) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Ypbind
echo "===Ypbind===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(ypbind) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Ypserv
echo "===Ypserv===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(ypserv) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Zerofree
echo "===Zerofree===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libzerofree|zerofree) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Zlib
echo "===Zlib===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(zlib) ]]; then
        echo "- '''${package}''' ${package_versions[$package]}" >> MediawikiPage.txt
	# Other
    else
        # Do nothing
		:
    fi
done
echo "" >> MediawikiPage.txt
# --- Zstd
echo "===Zstd===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libzstd|zstd) ]]; then
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
    if [[ "$package" =~ ^(acl|adduser|algorithm|alpine|amd|apache|apparmor|apport|apt|bash|bind9|binutils|blockdev|bolt|busybox|byobu|bzip|certbot|class|cpp|cron|cryptsetup|curl|dash|datetime|dbus|dpkg|eject|ethtool|fakeroot|falcon\-sensor|fdisk|file|fonts|g++|gawk|gcc|git|gpg|grep|grub|gzip|hostname|htop|init|iproute|iptables|iputils|libacl|libalgorithm|libalpine|libamd|libapache|libapparmor|libapt|libbinutils|libblockdev|libbzip|libclass|libcpp|libcryptsetup|libcurl|libdash|libdatetime|libfdisk|libg++|libgawk|libgcc|libgpg|libncurses|libnetplan|libntp|libopenssh|libpam|libparted|libpasswd|libperl|libphp|libplymouth|libpolkit|libpostfix|libpython|libsystemd|libtar|libtcl|libtss|libusb|libvim|libwget|libxauth|libxkb|libxml|libxxd|libxymon|libxz|libyaml|libzerofree|libzstd|linux|mariadb|mysql|ncurses|netcat|netplan|ntp|openssh|parted|passwd|perl|php|plymouth|polkit|pollinate|postfix|python|rsync|samba|screen|sed|sendemail|sg3|sosreport|sudo|systemd|tar|tcl|tcpdump|telnet|thermald|time|tmpreaper|tss|ubuntu|ucf|udev|ufw|unzip|usb|usrmerge|vim|webmin|wget|whiptail|xauth|xkb|xml|xxd|xymon|xz|yaml|yp\-tools|ypbind|ypserv|zerofree|zlib|zstd) ]]; then
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