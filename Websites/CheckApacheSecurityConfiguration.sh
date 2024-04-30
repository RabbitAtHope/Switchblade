#!/bin/bash
cat /etc/apache2/conf-enabled/security.conf | grep "ServerSignature"
cat /etc/apache2/conf-enabled/security.conf | grep "ServerTokens"
