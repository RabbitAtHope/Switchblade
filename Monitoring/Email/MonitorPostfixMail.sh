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
# Dropped / Sent Percentage
#//////////////////////////

# Get count of sent emails
sent_count=$(grep "status=sent" /var/log/mail.log | wc -l)

# Get count of dropped emails
dropped_count=$(grep -E "status=(bounced|deferred|expired|rejected)" /var/log/mail.log | wc -l)

# Break dropped email count down by the reason
bounced_count=$(grep -E "status=(bounced)" /var/log/mail.log | wc -l)
bounced_count_badreceiver=$(grep "status=bounced" /var/log/mail.log | grep "The email account that you tried to reach does not exist" | wc -l)
bounced_count_nomessageid=$(grep "status=bounced" /var/log/mail.log | grep "Messages missing a valid Message-ID header" | wc -l)
bounced_count_mailboxunreachable=$(grep "status=bounced" /var/log/mail.log | grep "mailbox unavailable or not local" | wc -l)
deferred_count=$(grep -E "status=(deferred)" /var/log/mail.log | wc -l)
deferred_count_hostnotfound=$(grep "status=deferred" /var/log/mail.log | grep "Host or domain name not found" | wc -l)
deferred_count_ratelimitednoauth=$(grep "status=deferred" /var/log/mail.log | grep "This mail has been rate limited because it is unauthenticated" | wc -l)
expired_count=$(grep -E "status=(expired)" /var/log/mail.log | wc -l)
rejected_count=$(grep -E "status=(rejected)" /var/log/mail.log | wc -l)

# Calculate the percentage of dropped mail
if [ "$sent_count" -eq 0 ]; then
    echo -e "No sent emails in the specified time period."
else
    drop_percentage=$(echo "scale=2; $dropped_count / $sent_count * 100" | bc)
	
    echo -e "[${green}>${none}] Sent emails: ${white}[${none}${green}${sent_count}${none}${white}]${none}"
	echo ""
	
    echo -e "[${red}x${none}] Dropped emails: ${white}[${none}${red}${dropped_count}${none}${white}]${none}"
	
	echo -e " [${red}x${none}] Bounced: ${white}[${none}${red}${bounced_count}${none}${white}]${none}"
	echo -e "  - Bad recipient: ${white}[${none}${red}${bounced_count_badreceiver}${none}${white}]${none}"
	echo -e "  - Mailbox unreachable: ${white}[${none}${red}${bounced_count_mailboxunreachable}${none}${white}]${none}"
	echo -e "  - No message ID: ${white}[${none}${red}${bounced_count_nomessageid}${none}${white}]${none}"
	echo -e "  - Other: ${white}[${none}${red}$(($bounced_count-$(($bounced_count_badreceiver+$bounced_count_nomessageid+bounced_count_mailboxunreachable))))${none}${white}]${none}"
	echo -e " [${red}x${none}] Deferred: ${white}[${none}${red}${deferred_count}${none}${white}]${none}"
	echo -e "  - Host not found: ${white}[${none}${red}${deferred_count_hostnotfound}${none}${white}]${none}"
	echo -e "  - Rate limited unauthenticated host: ${white}[${none}${red}${deferred_count_ratelimitednoauth}${none}${white}]${none}"
	echo -e "  - Other: ${white}[${none}${red}$(($deferred_count-$(($deferred_count_hostnotfound+$deferred_count_ratelimitednoauth))))${none}${white}]${none}"
	echo -e " [${red}x${none}] Expired: ${white}[${none}${red}${expired_count}${none}${white}]${none}"
	echo -e " [${red}x${none}] Rejected: ${white}[${none}${red}${rejected_count}${none}${white}]${none}"
	echo ""
	
    echo -e "[${red}%${none}] Percentage of dropped mail: ${white}[${none}${red}${drop_percentage}${none}%${white}]${none}"
fi

echo ""

#//////////////////////////