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

echo -e "Finding all [${green}.git${none}] files..."

sudo find / -type f -iname .git

echo ""

#//////////////////////////

echo -e "Finding all [${green}.gitattributes${none}] files..."

sudo find / -type f -iname .gitattributes

echo ""

#//////////////////////////

echo -e "Finding all [${green}.github${none}] files..."

sudo find / -type f -iname .github

echo ""

#//////////////////////////

echo "Finding all [${green}.gitignore${none}] files..."

sudo find / -type f -iname .gitignore

echo ""

#//////////////////////////

echo "Finding all [${green}.gitmodules${none}] files..."

sudo find / -type f -iname .gitmodules

echo ""

#//////////////////////////