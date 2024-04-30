#!/bin/bash

# Perform the updates
sudo apt-get update
sudo apt-get upgrade -y

# Clean up
sudo apt-get autoclean
sudo apt-get autoremove -y
