#!/bin/bash

# Checking web servers
apache2 -v 2> /dev/null
httpd -v 2> /dev/null
nginx -v 2> /dev/null
lighttpd -v 2> /dev/null

# Checking databases
mysql -V 2> /dev/null
mariadb -V 2> /dev/null
percona -V 2> /dev/null
psql --version 2> /dev/null
redis-server --version 2> /dev/null
mongod --version 2> /dev/null

# Checking programming languages
php -v 2> /dev/null
python --version 2> /dev/null
python3 --version 2> /dev/null
ruby -v 2> /dev/null

echo "[Success] Retrieved all possible LAMP version information."
