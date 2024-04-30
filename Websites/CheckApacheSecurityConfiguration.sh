#!/bin/bash

# ServerSignature
echo "Checking the [ServerSignature] setting, which should be set to [Off]..."
cat /etc/apache2/conf-enabled/security.conf | grep "ServerSignature" | grep -v "#ServerSignature"  | grep -v "# ServerSignature"

# ServerTokens
echo "Checking the [ServerTokens] setting, which should be set to [Prod]..."
cat /etc/apache2/conf-enabled/security.conf | grep "ServerTokens" | grep -v "#ServerTokens"  | grep -v "# ServerTokens"
