#!/bin/bash

# Apache2
sudo systemctl restart apache2

# Httpd
sudo systemctl restart httpd
sudo systemctl restart httpd24-httpd

# Tomcat
sudo systemctl restart tomcat
