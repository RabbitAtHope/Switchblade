#!/bin/bash

# Apache2
sudo systemctl status apache2 2> /dev/null

# Caddy
sudo systemctl status caddy 2> /dev/null

# Cherokee
sudo systemctl status cherokee 2> /dev/null

# Httpd
sudo systemctl status httpd 2> /dev/null
sudo systemctl status httpd24-httpd 2> /dev/null

# Jetty
sudo systemctl status jetty 2> /dev/null

# Lighttpd
sudo systemctl status lighttpd 2> /dev/null

# Nginx
sudo systemctl status nginx 2> /dev/null

# Tomcat
sudo systemctl status tomcat 2> /dev/null

echo "[Success] Checked all possible web services."