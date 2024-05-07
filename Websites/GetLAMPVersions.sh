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

echo -e "[${yellow}Web${none}] Checking [web server] versions..."

# Checking web servers
apache2 -v 2> /dev/null
httpd -v 2> /dev/null
nginx -v 2> /dev/null
lighttpd -v 2> /dev/null

echo ""

#//////////////////////////

echo -e "[${yellow}Databases${none}] Checking [database] versions..."

# Checking databases
mariadb -V 2> /dev/null
mongod --version 2> /dev/null
mysql -V 2> /dev/null
percona -V 2> /dev/null
psql --version 2> /dev/null
redis-server --version 2> /dev/null

echo ""

#//////////////////////////

echo -e "[${yellow}Languages${none}] Checking [programming language] versions..."

# Checking programming languages
php -v 2> /dev/null
python --version 2> /dev/null
python3 --version 2> /dev/null
ruby -v 2> /dev/null

echo ""

#//////////////////////////

echo -e "[${green}Success${none}] Retrieved all possible LAMP version information."
