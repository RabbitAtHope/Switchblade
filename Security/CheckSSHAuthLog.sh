#!/bin/bash

echo ""

#//////////////////////////

echo "Fetching all [successful recent logins]..."

# Get all recent logins and the IP addresses they came from.
sudo cat /var/log/auth.log 2> /dev/null | grep "Accepted password" | sort

echo ""

#//////////////////////////

echo "Fetching recent [failed attempts] to [existing accounts] that aren't [root]..."

# Get all recent failed login attempts to accounts that exist.
sudo cat /var/log/auth.log 2> /dev/null | grep "Failed password for" | grep -v "Failed password for invalid user" | grep -v "Failed password for root" | sort

echo ""

#//////////////////////////

echo "Fetching recent [failed attempts] to [nonexistent accounts], which are likely brute force attempts..."

# Get all recent failed login attempts to accounts that DON'T exist.
sudo cat /var/log/auth.log 2> /dev/null | grep "Failed password for invalid user" | sort

echo ""

#//////////////////////////

echo "Fetching recent [failed attempts] to log into [root], which are likely malicious attempts..."

# Get all recent failed login attempts to the root account.
sudo cat /var/log/auth.log 2> /dev/null | grep "Failed password for root" | sort

echo ""

#//////////////////////////