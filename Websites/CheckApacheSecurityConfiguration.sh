#!/bin/bash

echo ""

#//////////////////////////

# ServerSignature
echo "Checking the [ServerSignature] setting, which should be set to [Off]..."

cat /etc/apache2/apache2.conf 2>/dev/null | grep "ServerSignature" | grep -v "#ServerSignature"  | grep -v "# ServerSignature"
cat /etc/apache2/conf-enabled/security.conf 2>/dev/null | grep "ServerSignature" | grep -v "#ServerSignature"  | grep -v "# ServerSignature"
cat /etc/httpd/conf-enabled/security.conf 2>/dev/null | grep "ServerSignature" | grep -v "#ServerSignature"  | grep -v "# ServerSignature"
cat /etc/httpd/httpd.conf 2>/dev/null | grep "ServerSignature" | grep -v "#ServerSignature"  | grep -v "# ServerSignature"

echo ""

#//////////////////////////

# ServerTokens
echo "Checking the [ServerTokens] setting, which should be set to [Prod]..."

cat /etc/apache2/apache2.conf 2>/dev/null | grep "ServerTokens" | grep -v "#ServerTokens"  | grep -v "# ServerTokens"
cat /etc/apache2/conf-enabled/security.conf 2>/dev/null | grep "ServerTokens" | grep -v "#ServerTokens"  | grep -v "# ServerTokens"
cat /etc/httpd/conf-enabled/security.conf 2>/dev/null | grep "ServerTokens" | grep -v "#ServerTokens"  | grep -v "# ServerTokens"
cat /etc/httpd/httpd.conf 2>/dev/null | grep "ServerTokens" | grep -v "#ServerTokens"  | grep -v "# ServerTokens"

echo ""

#//////////////////////////

echo "[Success] Checked all possible configuration locations."