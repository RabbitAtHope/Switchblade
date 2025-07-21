#!/bin/bash

# It's recommended that if you use this script as written with just a blind list of usernames, you leave it running overnight, as it will take several hours to complete depending on the speed of your server.
# If you insert a shorter list of known usernames on your machine, this will go much faster.

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

#//////////////////////////

echo ""
echo -e "////////////////////////////////////////////////////"
echo -e "/          [${yellow}DEFAULT PASSWORD TESTING${none}]              /"
echo -e "////////////////////////////////////////////////////"
echo ""

#//////////////////////////

# Common passwords that will probably work for any account.
# Add your own targeted passwords to this list if desired.
passwords=("123" "1234" "12345" "123456" "1234567" "12345678" "abc123" "abc123!" "access" "access123" "access123!" "adm" "adm123" "adm123!" "admin" "admin123" "admin123!" "admin1234" "admin1234!" "administrator" "administrator123" "administrator123!" "admins" "alpine" "ansible" "ansible123" "ansible123!" "baseball" "basketball" "batman" "cadillac" "calvin" "Changem3" "Changeme" "changem3" "changeme" "cisco" "computer" "computers" "connect" "connection" "cookie" "daniel" "debian" "default" "defaultpass" "defaultpassword" "dragon" "ferrari" "final" "football" "fuck" "fuckyou" "hello" "hello123" "hello123!" "help" "helpdesk" "helpme" "hockey" "hunter" "hunter123" "hunter123!" "iloveyou" "letmein" "letmein123" "letmein123!" "library" "linux" "login" "login123" "login123!" "logon" "logon123" "logon123!" "maintenance" "master" "mercedes" "michael" "nproc" "oracle" "oracle123" "oracle123!" "pass" "pass123" "pass123!" "Passw0rd" "Passw0rd123" "Passw0rd123!" "Passw0rd!" "passw0rd" "passw0rd123" "passw0rd123!" "passw0rd!" "passwd" "passwd123" "passwd123!" "password" "password1" "password123" "password123!" "password1234" "password1234!" "pikachu" "placeholder" "placeholder123" "placeholder123!" "pokemon" "qwerty" "qwerty1" "qwerty123" "qwerty123!" "raspberry" "raspberrypi" "root" "root123" "root123!" "sales" "soccer" "spiderman" "sports" "superman" "support" "support123" "support123!" "sys" "system" "tennis" "test" "test123" "test123!" "test1234" "test1234!" "testpass" "testpassword" "tomcat" "tomcat123" "tomcat123!" "toor" "toor123" "toor123!" "user" "user123" "user123!" "vagrant" "web" "web123" "web123!" "webadmin" "webmaster" "yugioh")
passwords_length=${#passwords[@]}

# Common usernames to test for most accounts (replace with known usernames if you have access to the list of users on the machine)
usernames=("_apt" "aaron" "abrt" "access" "adam" "adm" "adm0" "adm01" "adm02" "adm03" "adm1" "adm2" "adm3" "admin" "admin1" "admin2" "admin3" "administrator" "alan" "anon" "ansible" "apache" "arpwatch" "auditor" "avahi" "avahi-autoipd" "backup" "bb" "bbs" "bin" "bitnami" "bob" "brian" "calvin" "charles" "charlie" "checkfs" "checkfsys" "checksys" "chronos" "chrony" "cisco" "class" "classroom" "cmwlogin" "cockpit-ws" "colord" "connect" "couchdb" "cron" "cups-pk-helper" "daemon" "dan" "daniel" "dave" "david" "dbadmin" "dbus" "dean" "deb" "debian" "default" "demo" "demos" "diag" "distccd" "dni" "dnsmasq" "doug" "faculty" "fal" "fax" "ftp" "ftpuser" "games" "garcia" "gdm" "george" "gnats" "gnome-initial-setup" "gomez" "gopher" "guest" "guestuser" "halt" "harold" "helpdesk" "hplip" "hunter" "inetsim" "informix" "install" "iodine" "irc" "jacob" "james" "jeff" "jet" "jim" "joe" "john" "jon" "joseph" "landscape" "lib" "library" "lightdm" "list" "listen" "lp" "lpadm" "lpadmin" "lxd" "lynx" "mail" "man" "master" "matt" "matthew" "me" "messagebus" "meyers" "michael" "mike" "miredo" "mitch" "mountfs" "mountfsys" "mountsys" "mysql" "nate" "nathan" "news" "noaccess" "nobody" "nobody4" "nproc" "ntp" "omi" "omsagent" "operator" "oracle" "oracle8" "parker" "paul" "peter" "peterson" "pi" "placeholder" "polkitd" "pollinate" "popr" "postfix" "postgres" "postmaster" "printer" "proxy" "public" "pulse" "ray" "reynolds" "richard" "rob" "robert" "roger" "rogers" "root" "ROOT" "rooty" "rpc" "rpcuser" "rtkit" "sales" "service" "setup" "sftp" "sftpuser" "shutdown" "smith" "spencer" "squid" "sshd" "sslh" "sssd" "staff" "stephen" "steve" "steven" "stevens" "stewart" "student" "studio" "super" "superadmin" "superuser" "support" "sync" "sys" "sysadm" "sysadmin" "sysbin" "syslog" "system" "tcpdump" "test" "testuser" "thomas" "tim" "tom" "tomcat" "toor" "trouble" "tss" "tucker" "tyler" "udadmin" "ultra" "umountfs" "umountfsys" "umountsys" "unix" "upload" "usbmux" "user" "uucp" "uucpadm" "uuidd" "vagrant" "varnish" "walter" "web" "webadmin" "webmaster" "white" "whoopsie" "will" "william" "williams" "wright" "www" "www-data" "wwwdata" "xpdb" "xpopr" "xymon" "young" "zabbix" "zachary")
usernames_length=${#usernames[@]}

#//////////////////////////

echo ""

#//////////////////////////

# [FTP]

echo -e "////////////////////////// ${white}[${none} ${yellow}FTP${none} ${white}]${none} //////////////////////////"
echo ""

#//////////////////////////

# Check if any service is listening on the FTP port (usually port 21)
if nc -z localhost 21 &> /dev/null; then

    echo -e "[${yellow}FTP${none}] is present and listening for connections on this server."
	
	# Try to login with these credentials.
	# echo -e "your_username\nyour_password\nquit" | ftp -n localhost
	
else
    echo -e "[${yellow}FTP${none}] is [${red}not present and listening for connections${none}] on this server."
fi

echo ""

#//////////////////////////

# [HTTP/HTTPS]
# Look for common login portals and try some common default username/password combinations for that specific vendor/software.

echo -e "////////////////////////// ${white}[${none} ${yellow}HTTP/HTTPS${none} ${white}]${none} //////////////////////////"
echo ""

#//////////////////////////

# Get the base DNS name of this server to start with
IP_ADDRESS=$(hostname -I | awk '{print $1}')
dnsname=$(nslookup $IP_ADDRESS | grep 'name =' | awk -F'=' '{print $2}' | sed 's/^\s*//g')
dnsname=${dnsname%.} # Remove period at end

# Uncomment this if you want to test a remote server rather than this one.
#dnsname=""

echo -e "[${yellow}Server DNS Name${none}]: ${dnsname}"
echo ""

# Look for known login portals
echo -e "[${yellow}HTTP/HTTPS${none}] Looking for known login portals..."
echo ""

#//////////////////////////
# GENERIC / NONSPECIFIC
#//////////////////////////

POSSIBLE_LOGIN_URLS=("$dnsname/login/index.php" "$dnsname/login.php" "$dnsname/users/sign_in")

# For each possible login portal URL...
for LOGIN_URL in "${POSSIBLE_LOGIN_URLS[@]}"; do

	# Check if it exists
	response_code=$(curl -s -o /dev/null -w "%{http_code}" "$LOGIN_URL")
	if [[ "$response_code" == "200" || "$response_code" == "401" || "$response_code" == "403" ]]; then

		echo ""
		echo -e "[${green}x${none}] [${green}Unknown${none}] login portal found: [${yellow}${LOGIN_URL}${none}]"
		echo ""
		
		# For each password...
		counter=0
		for pass in "${passwords[@]}"; do

		  counter=$((counter+1))
		  echo -e "Trying ${white}[${none}${yellow}${pass}${none}${white}]${none} (${lightpurple}${counter}${none}/${purple}${passwords_length}${none}) against [${lightpurple}${usernames_length}${none}] usernames..."
		  echo -e -n " ${orange}[${none}"

		  # For each username...
		  for user in "${usernames[@]}"; do
		  
			echo -e -n "${yellow}=${none}"
			
			# "username" "password"
			# Try to login
			LOGIN_RESPONSE=$(curl -s -d "username=$user&password=$pass" -X POST $LOGIN_URL)
			
			# Check if the response code indicates success (200)
			if [[ $LOGIN_RESPONSE == *"200" ]]; then
				echo ""
				echo -e "[${red}!${none}] Username: [${red}${user}${none}], Password: [${red}${pass}${none}]"
				echo ""
				
				# Pause and wait for user input.
				read -p "Press [${yellow}Enter${none}] to continue..."
			else
				# echo -e "[${red}Failed${none}] Login failed. HTTP response code: [${red}$(echo "$LOGIN_RESPONSE" | grep -o '<title>[^<]*</title>' | sed -e 's/<title>\(.*\)<\/title>/\1/')${none}]"
				:
			fi

		  done
		  
		  echo -e "${orange}]${none}"
		  
		done

	else
		:
	fi
done

echo ""

#//////////////////////////
# WORDPRESS
#//////////////////////////

LOGIN_URL="$dnsname/wp-login.php"

# Check if it exists
response_code=$(curl -s -o /dev/null -w "%{http_code}" "$LOGIN_URL")
if [ "$response_code" == "401" || "$response_code" == "403" ]; then

    echo -e "[${green}x${none}] [${lightblue}WordPress${none}] login portal found: [${yellow}${LOGIN_URL}${none}]"
	echo ""
	
	# Try to fetch usernames from /wp-json/wp/v2/users
	USERS_URL="$dnsname/wp-json/wp/v2/users"
	response_code=$(curl -s -o /dev/null -w "%{http_code}" "$USERS_URL")
	if [ "$response_code" == "200" ]; then
	
		# Jackpot! Harvest the user list.
		echo -e " Harvesting username list from [${yellow}/wp-json/wp/v2/users${none}]..."
		wordpressusernames=$(curl -s "$USERS_URL" | jq -r '.[].slug')
		wordpressusernames=($wordpressusernames)
		wordpressusernames_length=${#wordpressusernames[@]}
		
		echo -e " Found ${white}[${none}$wordpressusernames_length${white}]${none} usernames:"
		for username in "${wordpressusernames[@]}"; do
			echo -e " - [${green}$username${none}]"
		done
		echo ""
	
	else
	
		# Just use some common default WordPress logins.
		echo -e " Could not access [${yellow}/wp-json/wp/v2/users${none}], using some [common usernames] instead..."
		wordpressusernames=("adm" "admin" "admin1" "manager" "root" "support" "sysadmin" "test" "user" "wordpress" "wp" "wp-admin" "wpadmin")
		wordpressusernames_length=${#wordpressusernames[@]}
	
	fi
	
	# For each password...
	counter=0
	for pass in "${passwords[@]}"; do

	  counter=$((counter+1))
	  echo -e "Trying ${white}[${none}${yellow}${pass}${none}${white}]${none} (${lightpurple}${counter}${none}/${purple}${passwords_length}${none}) against [${lightpurple}${wordpressusernames_length}${none}] usernames..."
	  echo -e -n " ${orange}[${none}"

	  # For each username...
	  for user in "${wordpressusernames[@]}"; do
	  
		echo -e -n "${yellow}=${none}"
		
		# Try to login
		LOGIN_RESPONSE=$(curl -s -d "username=$user&password=$pass" -X POST $LOGIN_URL)
		
		# Check if the response code indicates success (200)
		if [[ $LOGIN_RESPONSE == *"200" ]]; then
			echo ""
			echo -e "[${red}!${none}] Username: [${red}${user}${none}], Password: [${red}${pass}${none}]"
			echo ""
				
			# Pause and wait for user input.
			read -p "Press [${yellow}Enter${none}] to continue..."
		else
			# echo -e "[${red}Failed${none}] Login failed. HTTP response code: [${red}$(echo "$LOGIN_RESPONSE" | grep -o '<title>[^<]*</title>' | sed -e 's/<title>\(.*\)<\/title>/\1/')${none}]"
			:
		fi

	  done
	  
	  echo -e "${orange}]${none}"
	  
	done
else
    :
fi

echo -e "[${yellow}HTTP/HTTPS${none}] Finished looking for login portals."
echo ""

#//////////////////////////

# [SSH]
# Try some common SSH username and password combinations.
# If any of these commands work and give back a username that ISN'T the user you're trying the script from, that account's password should be changed!

echo -e "////////////////////////// ${white}[${none} ${yellow}SSH${none} ${white}]${none} //////////////////////////"
echo ""

echo -e "[${yellow}SSH${none}] Testing for default or common SSH accounts and passwords..."
echo ""

#//////////////////////////

# For each password...
counter=0
for pass in "${passwords[@]}"; do

  counter=$((counter+1))
  echo -e "Trying ${white}[${none}${yellow}${pass}${none}${white}]${none} (${lightpurple}${counter}${none}/${purple}${passwords_length}${none}) against [${lightpurple}${usernames_length}${none}] usernames..."
  echo -e -n " ${orange}[${none}"

  # For each username...
  for user in "${usernames[@]}"; do
  
	echo -e -n "${yellow}=${none}"

    # Clear sudo cache.
    # sudo -k

    # Test the credential pair by running "whoami" as the given user. Suppress error responses.
    output=$(echo -e "$pass\n" | su -c "whoami" $user 2>/dev/null)
	
	# Uncomment this if you want to log into a remote server rather than this one.
	# host=""
	# output=$(echo -e "$pass\n" | sshpass -p "$pass" ssh -o StrictHostKeyChecking=no "$user@$host" 'whoami' 2>/dev/null)
	
    # Check if the output matches the expected username.
    if [[ $output == $user ]]; then
	
      # Check if we can access the user's home directory.
      home_path="/home/$user"
	  
      if [[ -d $home_path ]]; then
	  
        # Try listing files in the user's home directory as a verification step.
		# Note that this won't work for users that don't have any files.
        list_files=$(echo -e "$pass\n" | su -c "ls -la \"$home_path\"" $user)
        
        if [[ $list_files != "" ]]; then
			echo ""
			echo -e "[${red}!${none}] Username: [${red}${user}${none}], Password: [${red}${pass}${none}]"
			echo ""
				
			# Pause and wait for user input.
			read -p "Press [${yellow}Enter${none}] to continue..."
		else
			echo ""
			echo -e "[${green}Possible Success${none}] (No Home Files) Username: [${green}${user}${none}], Password: [${green}${pass}${none}]"
			:
		fi
		
	  else
	   # echo "[Failed] (Couldn't Access Home Directory) Username: [$user], Password: [$pass]"
	   :
	  fi

    else
      # echo "[Failed] Username: [$user], Password: [$pass]"
	  :
    fi
	
  done
  
  echo -e "${orange}]${none}"
  
done

#//////////////////////////