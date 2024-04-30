#!/bin/bash

# Try some common username and password combinations.
# If any of these commands work and give back a username that ISN'T the user you're trying the script from, that account's password should be changed!

# Usernames to test
usernames=("access" "adm" "adm0" "adm1" "adm2" "adm3" "admin" "administrator" "ansible" "apache" "bb" "cisco" "cron" "daemon" "faculty" "ftp" "guest" "irc" "john" "master" "michael" "mike" "mysql" "nproc" "oracle" "oracle8" "postfix" "postgres" "postmaster" "proxy" "public" "root" "rpc" "sales" "shutdown" "squid" "sshd" "staff" "support" "sync" "sys" "syslog" "system" "test" "testuser" "tomcat" "toor" "user")
# Passwords to test
passwords=("1234" "12345" "123456" "1234567" "12345678" "abc123" "adm" "admin" "admin123" "administrator" "admins" "alpine" "baseball" "basketball" "Changem3" "changem3" "changeme" "cisco" "football" "hockey" "letmein" "linux" "login" "logon" "maintenance" "master" "pass" "Passw0rd" "passw0rd" "passwd" "password" "password123" "password123!" "password1234" "qwerty" "qwerty123" "root" "soccer" "support" "test" "test123" "test123!" "test1234" "toor" "user" "webadmin" "webmaster")

# For each password...
for pass in "${passwords[@]}"; do

  echo "Trying [$pass]..."

  # For each username...
  for user in "${usernames[@]}"; do

    # Clear sudo cache.
    # sudo -k

    # Test the credential pair by running "whoami" as the given user. Suppress error responses.
    output=$(echo -e "$pass\n" | su -c "whoami" $user 2>/dev/null)
	
    # Check if the output matches the expected username.
    if [[ $output == $user ]]; then
	
      # Check if we can access the user's home directory.
      home_path="/home/$user"
	  
      if [[ -d $home_path ]]; then
	  
        # Try listing files in the user's home directory as a verification step.
		# Note that this won't work for users that don't have any files.
        list_files=$(echo -e "$pass\n" | su -c "ls -la \"$home_path\"" $user)
        
        if [[ $list_files != "" ]]; then
			echo "[Success] Username: [$user], Password: [$pass]"
		else
			echo "[Possible Success] (No Home Files) Username: [$user], Password: [$pass]"
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
done
