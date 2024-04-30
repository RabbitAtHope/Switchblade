#!/bin/bash

# ServerSignature
echo "Checking the [ServerSignature] setting, which should be set to [Off]..."
cat /etc/apache2/conf-enabled/security.conf 2>/dev/null | grep "ServerSignature" | grep -v "#ServerSignature"  | grep -v "# ServerSignature"
cat /etc/httpd/conf-enabled/security.conf 2>/dev/null | grep "ServerSignature" | grep -v "#ServerSignature"  | grep -v "# ServerSignature"

# ServerTokens
echo "Checking the [ServerTokens] setting, which should be set to [Prod]..."
cat /etc/apache2/conf-enabled/security.conf 2>/dev/null | grep "ServerTokens" | grep -v "#ServerTokens"  | grep -v "# ServerTokens"
cat /etc/httpd/conf-enabled/security.conf 2>/dev/null | grep "ServerTokens" | grep -v "#ServerTokens"  | grep -v "# ServerTokens"
