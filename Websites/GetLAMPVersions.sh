#!/bin/bash

apache2 -v 2> /dev/null
httpd -v 2> /dev/null
mysql -V 2> /dev/null
nginx -v 2> /dev/null
php -v 2> /dev/null

echo "[Success] Retrieved all possible LAMP version information."
