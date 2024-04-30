#!/bin/bash

# Scan for possible r57 and c99 shell installations.
# Note that this script may produce false positives. If you're worried about accidentally executing a webshell while searching, don't run this command as sudo!
sudo find / -name "*".php -type f -print0 | xargs -0 grep r57 | uniq -c | sort -u | cut -d":" -f1 | grep -v Binary | uniq | grep -v "/usr/share/doc/git/RelNotes" | grep -v "/usr/share/vim/vim82/doc/syntax.txt"
sudo find / -name "*".php -type f -print0 | xargs -0 grep c99 | uniq -c | sort -u | cut -d":" -f1 | grep -v Binary | uniq | grep -v "/usr/share/doc/git/RelNotes" | grep -v "/usr/share/vim/vim82/doc/syntax.txt"
sudo find / -name "*".txt -type f -print0 | xargs -0 grep r57 | uniq -c | sort -u | cut -d":" -f1 | grep -v Binary | uniq | grep -v "/usr/share/doc/git/RelNotes" | grep -v "/usr/share/vim/vim82/doc/syntax.txt"
sudo find / -name "*".txt -type f -print0 | xargs -0 grep c99 | uniq -c | sort -u | cut -d":" -f1 | grep -v Binary | uniq | grep -v "/usr/share/doc/git/RelNotes" | grep -v "/usr/share/vim/vim82/doc/syntax.txt"
sudo find / -name "*".gif -type f -print0 | xargs -0 grep r57 | uniq -c | sort -u | cut -d":" -f1 | grep -v Binary | uniq | grep -v "/usr/share/doc/git/RelNotes" | grep -v "/usr/share/vim/vim82/doc/syntax.txt"
sudo find / -name "*".gif -type f -print0 | xargs -0 grep c99 | uniq -c | sort -u | cut -d":" -f1 | grep -v Binary | uniq | grep -v "/usr/share/doc/git/RelNotes" | grep -v "/usr/share/vim/vim82/doc/syntax.txt"
