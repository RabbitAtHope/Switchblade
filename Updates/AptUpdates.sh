#!/bin/bash

echo ""

#//////////////////////////

echo "[Installing] updates..."

# Perform the updates
sudo apt-get update
sudo apt-get upgrade -y

echo ""

#//////////////////////////

echo "[Cleaning up] after updates..."

# Clean up
sudo apt-get autoclean
sudo apt-get autoremove -y

echo ""

#//////////////////////////

echo "[Success] Updates installed."