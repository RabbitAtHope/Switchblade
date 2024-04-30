#!/bin/bash
cat /etc/apache2/conf-enabled/security.conf | grep "ServerSignature" | grep -v "#ServerSignature"  | grep -v "# ServerSignature"
cat /etc/apache2/conf-enabled/security.conf | grep "ServerTokens" | grep -v "#ServerTokens"  | grep -v "# ServerTokens"
