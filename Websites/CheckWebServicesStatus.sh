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

echo -e "[${yellow}Apache${none}] Checking Apache services..."

# Apache2
sudo systemctl status apache2 2> /dev/null

# Httpd
sudo systemctl status httpd 2> /dev/null
sudo systemctl status httpd24-httpd 2> /dev/null

# Tomcat
sudo systemctl status tomcat 2> /dev/null

echo ""

#//////////////////////////

echo -e "[${yellow}Other${none}] Checking other services..."

# Caddy
sudo systemctl status caddy 2> /dev/null

# Cherokee
sudo systemctl status cherokee 2> /dev/null

# Jetty
sudo systemctl status jetty 2> /dev/null

# Lighttpd
sudo systemctl status lighttpd 2> /dev/null

# Nginx
sudo systemctl status nginx 2> /dev/null

echo ""

#//////////////////////////

echo -e "[${green}Success${none}] Checked all possible web services."