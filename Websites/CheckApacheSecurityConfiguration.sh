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

# ServerSignature
echo -e "Checking the [${yellow}ServerSignature${none}] setting, which should be set to [${yellow}Off${none}]..."

cat /etc/apache2/apache2.conf 2>/dev/null | grep "ServerSignature" | grep -v "#ServerSignature"  | grep -v "# ServerSignature"
cat /etc/apache2/conf-enabled/security.conf 2>/dev/null | grep "ServerSignature" | grep -v "#ServerSignature"  | grep -v "# ServerSignature"
cat /etc/httpd/conf-enabled/security.conf 2>/dev/null | grep "ServerSignature" | grep -v "#ServerSignature"  | grep -v "# ServerSignature"
cat /etc/httpd/httpd.conf 2>/dev/null | grep "ServerSignature" | grep -v "#ServerSignature"  | grep -v "# ServerSignature"

echo ""

#//////////////////////////

# ServerTokens
echo -e "Checking the [${yellow}ServerTokens${none}] setting, which should be set to [${yellow}Prod${none}]..."

cat /etc/apache2/apache2.conf 2>/dev/null | grep "ServerTokens" | grep -v "#ServerTokens"  | grep -v "# ServerTokens"
cat /etc/apache2/conf-enabled/security.conf 2>/dev/null | grep "ServerTokens" | grep -v "#ServerTokens"  | grep -v "# ServerTokens"
cat /etc/httpd/conf-enabled/security.conf 2>/dev/null | grep "ServerTokens" | grep -v "#ServerTokens"  | grep -v "# ServerTokens"
cat /etc/httpd/httpd.conf 2>/dev/null | grep "ServerTokens" | grep -v "#ServerTokens"  | grep -v "# ServerTokens"

echo ""

#//////////////////////////

echo -e "[${green}Success${none}] Checked all possible configuration locations."