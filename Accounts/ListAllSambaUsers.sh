#!/bin/bash

echo ""

#//////////////////////////

echo "[Samba users] on this machine:"

sudo pdbedit -L -v | grep "Unix username:" | sort

echo ""

#//////////////////////////