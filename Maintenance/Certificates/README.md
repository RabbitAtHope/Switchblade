Setting up a new certificate from scratch
1) `sudo certbot certonly --authenticator manual --preferred-challenges dns`
2) Copy the token
3) Create a new TXT record in Cloudflare with key _acme-challenge.hostname and value of the token.
4) Wait for a minute for it to kick in. Hit "ENTER" on the prompt.
5) (Optional) Reload/restart Apache.

Automating renewals
1) `sudo apt-get install dos2unix jq`
2) `sudo setfacl -R -m u:user:rwx /etc/letsencrypt/renewal`
3) Copy the `auth-hook.sh` and `cleanup-hook.sh` scripts into the directory. Use `dos2unix` if necessary.
4) Edit the .conf file to set `"authenticator = manual"` and `"pref_challs = dns-01,"` and add the following two lines:
`manual_auth_hook = /etc/letsencrypt/renewal/auth-hook.sh`
`manual_cleanup_hook = /etc/letsencrypt/renewal/cleanup-hook.sh`
(may want to also add `"manual_public_ip_logging_ok = True"`)
5) Make them both executable:
`sudo chmod +x auth-hook.sh`
`sudo chmod +x cleanup-hook.sh`
6) `certbot renew`.
