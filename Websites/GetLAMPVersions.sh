#!/bin/bash

echo ""

#//////////////////////////

echo "Checking [web server] versions..."

# Checking web servers
apache2 -v 2> /dev/null
httpd -v 2> /dev/null
nginx -v 2> /dev/null
lighttpd -v 2> /dev/null

echo ""

#//////////////////////////

echo "Checking [database] versions..."

# Checking databases
mariadb -V 2> /dev/null
mongod --version 2> /dev/null
mysql -V 2> /dev/null
percona -V 2> /dev/null
psql --version 2> /dev/null
redis-server --version 2> /dev/null

echo ""

#//////////////////////////

echo "Checking [programming language] versions..."

# Checking programming languages
php -v 2> /dev/null
python --version 2> /dev/null
python3 --version 2> /dev/null
ruby -v 2> /dev/null

echo ""

#//////////////////////////

echo "[Success] Retrieved all possible LAMP version information."
