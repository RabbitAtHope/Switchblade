#!/bin/sh

CF_API_TOKEN="YOUR API TOKEN" # DNS edit API token in Cloudflare
CF_ZONE_ID="YOUR ZONE ID" # zone ID in Cloudflare

# Extract the domain from Certbot's environment variables
DOMAIN="${CERTBOT_DOMAIN}"

echo "[Success] Using certbot domain: ${CERTBOT_DOMAIN}"

# Get the ID of the TXT record to delete
RECORD_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/${CF_ZONE_ID}/dns_records?type=TXT&name=_acme-challenge.${DOMAIN}" \
     -H "Authorization: Bearer ${CF_API_TOKEN}" \
     -H "Content-Type: application/json" | jq -r '.result[0].id')

# Delete the TXT record
if [ -n "${RECORD_ID}" ]; then
  RESPONSE=$(curl -s -X DELETE "https://api.cloudflare.com/client/v4/zones/${CF_ZONE_ID}/dns_records/${RECORD_ID}" \
       -H "Authorization: Bearer ${CF_API_TOKEN}" \
       -H "Content-Type: application/json")

  # Check if the record was deleted successfully
  if echo "${RESPONSE}" | jq -e '.success' > /dev/null; then
    echo "[Success] TXT record deleted successfully"
  else
    echo "[Failure] Failed to delete TXT record."
    exit 1
  fi
else
  echo "[Failure] No TXT record found."
fi
