#!/bin/bash

# Apache2
sudo systemctl restart apache2 2> /dev/null

# Caddy
sudo systemctl restart caddy 2> /dev/null

# Cherokee
sudo systemctl restart cherokee 2> /dev/null

# Httpd
sudo systemctl restart httpd 2> /dev/null
sudo systemctl restart httpd24-httpd 2> /dev/null

# Jetty
sudo systemctl restart jetty 2> /dev/null

# Lighttpd
sudo systemctl restart lighttpd 2> /dev/null

# Nginx
sudo systemctl restart nginx 2> /dev/null

# Tomcat
sudo systemctl restart tomcat 2> /dev/null

echo "[Success] Restarted all possible web services."