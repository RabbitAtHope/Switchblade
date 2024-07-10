#!/bin/bash

# Pretty colors.
red='\033[0;31m'
green='\033[0;32m'
orange='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
lightgray='\033[0;37m'
darkgray='\033[1;30m'
lightred='\033[1;31m'
lightgreen='\033[1;32m'
yellow='\033[1;33m'
lightblue='\033[1;34m'
lightpurple='\033[1;35m'
lightcyan='\033[1;36m'
white='\033[1;37m'
none='\033[0m'

echo ""

#//////////////////////////

echo -e "[${yellow}Preparation${none}] Making sure [tcpdump] is installed..."

# Install tcpdump if it isn't installed already.
sudo apt-get install tcpdump 2> /dev/null
sudo yum install tcpdump 2> /dev/null

echo -e "[${green}Success${none}] The [tcpdump] library is installed."

echo ""

#//////////////////////////

# Set the duration of the tcpdump capture in seconds.
DURATION=60

# Set the capture file.
OUTPUT_FILE="packetcapture.pcap"

echo -e "[${yellow}Capture${none}] Starting [tcpdump] capture of web traffic ([80, 443, 8080, 8443, 10000]) for [$DURATION] seconds..."
echo -e "If desired, now is the time to go to any web portals you suspect of transmitting passwords insecurely and submit some test credentials."

# Capture all traffic from ports 80, 443, 8080, 8443, 10000.
sudo tcpdump -w $OUTPUT_FILE -G $DURATION -W 1 'tcp port 80 or tcp port 443 or tcp port 8080 or tcp port 8443 or tcp port 10000' &
TCPDUMP_PID=$!

# Wait for the tcpdump process to complete.
wait $TCPDUMP_PID

echo -e "[${green}Success${none}] Packet capture complete."

echo ""

#//////////////////////////

# Filter the capture file to look for potential plaintext passwords.

echo -e "[${yellow}Searching${none}] packet capture data for possible [unencrypted passwords]..."

echo ""

#//////////////////////////

# Pass
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "Pass ="
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "Pass:"
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "Pass="
# pass
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "pass ="
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "pass:"
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "pass="

# Passwd
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "Passwd ="
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "Passwd:"
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "Passwd="
# passwd
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "passwd ="
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "passwd:"
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "passwd="

# Password
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "Password ="
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "Password:"
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "Password="
# password
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "password ="
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "password:"
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "password="

# PWD
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "PWD ="
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "PWD:"
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "PWD="
# Pwd
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "Pwd ="
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "Pwd:"
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "Pwd="
# pwd
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "pwd ="
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "pwd:"
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "pwd="

#//////////////////////////

echo ""

echo -e "[${green}Success${none}] Filtering complete."

echo ""

#//////////////////////////

echo -e "Cleaning up [capture file]..."

# Remove the capture file.
sudo rm $OUTPUT_FILE

echo ""

#//////////////////////////

echo "[Success] The capture file has been removed. Sniffing is complete."