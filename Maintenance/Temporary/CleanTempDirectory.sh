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

echo -e "[${yellow}Preparation${none}] Making sure [tmpreaper] is installed..."

# Install tmpreaper if it isn't installed already.
sudo apt-get install tmpreaper 2>/dev/null
sudo yum -y install tmpreaper 2>/dev/null

echo -e "[${green}Success${none}] The [tmpreaper] package is installed."

echo ""

#//////////////////////////

# Clean the temporary directory.

echo -e "[${yellow}Cleaning${none}] the temporary directory..."

tmpreaper --showdeleted 2d /tmp

echo ""

#//////////////////////////

echo -e "[${green}Success${none}] The /tmp directory has been cleaned."