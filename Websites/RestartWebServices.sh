#!/bin/bash

# Apache2
sudo systemctl restart apache2 2> /dev/null

# Httpd
sudo systemctl restart httpd 2> /dev/null
sudo systemctl restart httpd24-httpd 2> /dev/null

# Tomcat
sudo systemctl restart tomcat 2> /dev/null

echo "[Success] Restarted all possible web services."