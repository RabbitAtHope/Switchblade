#!/bin/bash

echo ""

#//////////////////////////

echo "[Installing] updates..."

# Perform the updates
sudo yum update -y

echo ""

#//////////////////////////

echo "[Cleaning up] after updates..."

# Clean up
sudo yum clean all -y

echo ""

#//////////////////////////

echo "[Success] Updates installed."