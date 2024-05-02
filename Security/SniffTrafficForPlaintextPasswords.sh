#!/bin/bash

echo ""

#//////////////////////////

echo "Making sure [tcpdump] is installed..."

# Install tcpdump if it isn't installed already.
sudo apt-get install tcpdump 2> /dev/null

echo ""

#//////////////////////////

# Set the duration of the tcpdump capture in seconds.
DURATION=60

# Set the capture file.
OUTPUT_FILE="packetcapture.pcap"

echo "Starting [tcpdump] capture of web traffic ([80, 443, 8080, 8443, 10000]) for [$DURATION] seconds..."
echo "If desired, now is the time to go to any web portals you suspect of transmitting passwords insecurely and submit some test credentials."

# Capture all traffic from ports 80, 443, 8080, 8443, 10000.
sudo tcpdump -w $OUTPUT_FILE -G $DURATION -W 1 'tcp port 80 or tcp port 443 or tcp port 8080 or tcp port 8443 or tcp port 10000' &
TCPDUMP_PID=$!

# Wait for the tcpdump process to complete.
wait $TCPDUMP_PID

echo "[Success] Packet capture complete."

echo ""

#//////////////////////////

# Filter the capture file to look for potential plaintext passwords.

echo "Searching the packet capture data for [unencrypted passwords]..."

sudo tcpdump -r $OUTPUT_FILE -A | grep -i "pass:"
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "pass="
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "passwd:"
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "passwd="
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "password:"
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "password="
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "pwd:"
sudo tcpdump -r $OUTPUT_FILE -A | grep -i "pwd="

echo "[Success] Filtering complete."

echo ""

#//////////////////////////

echo "Cleaning up [capture file]..."

# Remove the capture file.
sudo rm $OUTPUT_FILE

echo ""

#//////////////////////////

echo "[Success] The capture file has been removed. Sniffing is complete."