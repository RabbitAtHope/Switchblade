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

echo -e "[${red}Scanning${none}] for possible [${red}web shells${none}]..."

# Scan for possible r57 and c99 shell installations.
# Note that this script may produce false positives. If you're worried about accidentally executing a webshell while searching, don't run this command as sudo!
sudo find / -name "*".php -type f -print0 2>/dev/null | xargs -0 grep r57 2>/dev/null | uniq -c 2>/dev/null | sort -u 2>/dev/null | cut -d":" -f1 2>/dev/null | grep -v Binary | uniq 2>/dev/null | grep -v "/usr/share/doc/git/RelNotes" 2>/dev/null | grep -v "/usr/share/vim/vim82/doc/syntax.txt" 2>/dev/null | grep -v "Permission denied" 2>/dev/null
sudo find / -name "*".php -type f -print0 2>/dev/null | xargs -0 grep c99 2>/dev/null | uniq -c 2>/dev/null | sort -u 2>/dev/null | cut -d":" -f1 2>/dev/null | grep -v Binary | uniq 2>/dev/null | grep -v "/usr/share/doc/git/RelNotes" 2>/dev/null | grep -v "/usr/share/vim/vim82/doc/syntax.txt" 2>/dev/null | grep -v "Permission denied" 2>/dev/null
sudo find / -name "*".txt -type f -print0 2>/dev/null | xargs -0 grep r57 2>/dev/null | uniq -c 2>/dev/null | sort -u 2>/dev/null | cut -d":" -f1 2>/dev/null | grep -v Binary | uniq 2>/dev/null | grep -v "/usr/share/doc/git/RelNotes" 2>/dev/null | grep -v "/usr/share/vim/vim82/doc/syntax.txt" 2>/dev/null | grep -v "Permission denied" 2>/dev/null
sudo find / -name "*".txt -type f -print0 2>/dev/null | xargs -0 grep c99 2>/dev/null | uniq -c 2>/dev/null | sort -u 2>/dev/null | cut -d":" -f1 2>/dev/null | grep -v Binary | uniq 2>/dev/null | grep -v "/usr/share/doc/git/RelNotes" 2>/dev/null | grep -v "/usr/share/vim/vim82/doc/syntax.txt" 2>/dev/null | grep -v "Permission denied" 2>/dev/null
sudo find / -name "*".gif -type f -print0 2>/dev/null | xargs -0 grep r57 2>/dev/null | uniq -c 2>/dev/null | sort -u 2>/dev/null | cut -d":" -f1 2>/dev/null | grep -v Binary | uniq 2>/dev/null | grep -v "/usr/share/doc/git/RelNotes" 2>/dev/null | grep -v "/usr/share/vim/vim82/doc/syntax.txt" 2>/dev/null | grep -v "Permission denied" 2>/dev/null
sudo find / -name "*".gif -type f -print0 2>/dev/null | xargs -0 grep c99 2>/dev/null | uniq -c 2>/dev/null | sort -u 2>/dev/null | cut -d":" -f1 2>/dev/null | grep -v Binary | uniq 2>/dev/null | grep -v "/usr/share/doc/git/RelNotes" 2>/dev/null | grep -v "/usr/share/vim/vim82/doc/syntax.txt" 2>/dev/null | grep -v "Permission denied" 2>/dev/null

echo ""

#//////////////////////////

echo -e "[${green}Success${none}] Scanning complete."