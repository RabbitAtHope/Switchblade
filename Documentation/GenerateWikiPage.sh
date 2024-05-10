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
    version=$(apt-cache policy "$package" | grep 'Installed' | grep -v 'Listing...' | awk '{print $2}')
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
# --- Plymouth
echo "===Plymouth===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(plymouth) ]]; then
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
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(libpython|python) ]]; then
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
# --- All other packages
echo "===Other===" >> MediawikiPage.txt
for package in "${sorted_packages[@]}"; do
    if [[ "$package" =~ ^(acl|alpine|amd|apparmor|apt|bash|bind9|binutils|certbot|cryptsetup|curl|dpkg|gcc|gpg|grub|libacl|libalpine|libamd|libapparmor|libapt|libbinutils|libcryptsetup|libcurl|libgcc|libgpg|libncurses|libnetplan|libntp|libopenssh|libpam|libperl|libpostfix|libpython|libsystemd|libusb|libvim|libxymon|libyaml|linux|mariadb|mysql|ncurses|netplan|ntp|openssh|perl|plymouth|postfix|python|rsync|systemd|ubuntu|usb|vim|xymon|yaml|zlib) ]]; then
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