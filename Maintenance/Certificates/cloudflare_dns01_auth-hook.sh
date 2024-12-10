#!/bin/sh

CF_API_TOKEN="YOUR API TOKEN" # DNS edit API token in Cloudflare
CF_ZONE_ID="YOUR ZONE ID" # zone ID in Cloudflare

# Extract the domain and validation token from Certbot's environment variables
DOMAIN="${CERTBOT_DOMAIN}"
TOKEN_VALUE="${CERTBOT_VALIDATION}"

echo "[Success] Using certbot domain: ${CERTBOT_DOMAIN}"
echo "[Success] Using token value: ${CERTBOT_VALIDATION}"

# Create the TXT record
RESPONSE=$(curl -s -X POST "https://api.cloudflare.com/client/v4/zones/${CF_ZONE_ID}/dns_records" \
     -H "Authorization: Bearer ${CF_API_TOKEN}" \
     -H "Content-Type: application/json" \
     --data '{"type":"TXT","name":"_acme-challenge.'${DOMAIN}'","content":"'${TOKEN_VALUE}'","ttl":120}')

# Check if the record was created successfully
if echo "${RESPONSE}" | jq -e '.success' > /dev/null; then
  echo "[Success] TXT record created successfully"
else
  echo "[Failure] Failed to create TXT record"
  exit 1
fi

# Wait 60 seconds for it to propagate.
echo "[Success] Waiting 60 seconds for TXT record to propagate..."
sleep 60s
