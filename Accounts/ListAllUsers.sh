#!/bin/bash

echo ""

#//////////////////////////

echo "[Users] that can be logged into on this machine:"

sudo cat /etc/passwd | grep -v "/nologin" | sort

echo ""

#//////////////////////////

echo "[Users] that can be logged into with [shell access]:"

sudo cat /etc/passwd | grep -v "/nologin" | grep "/bin/bash" | sort

echo ""

#//////////////////////////

echo "[Users] that have logged in before:"

sudo lastlog | grep -v Never

echo ""