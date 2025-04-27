#!/bin/bash

# Boinc install script V0.1.5(BETA) for Debian based systems. This was tested on a Orange Pi 4A, please leave me feedback by contacting me on one of the platforms below. 
# Created by Spec,GOTSpectrum(LTT Forum), @gotspectrum.bsky.social, https://github.com/Spec-Q

# === WELCOME AND PROJECT ===
echo "~~~~~ Welcome to the BOINC install script $USER ~~~~~"
echo ""
echo "~~~~~ Please enter the project URL you would like to attach to! ~~~~~"
read PROJECT_URL
echo "OK! Attaching to project $PROJECT_URL "
echo ""

echo "Alright! Now we need your account key for the project $USER "
read ACCOUNT_KEY
echo "Using account key $ACCOUNT_KEY "
echo ""

# === CONFIGURATION ===
CPU_PERCENT=75.0                                   # % of cores to use
CPU_USAGE_LIMIT=80                                 # Max % CPU load per core
USER_TO_ADD="$USER"                                # Add current user to 'boinc' group

# === UPDATE & INSTALL ===

while true; do

read -p "Would you like to update packages prior to installing the boinc-client? (y/n)" SYSTEM_UPDATE
echo""

case $SYSTEM_UPDATE in
	[yY] ) echo "     OK! Updating packages now!"
		sudo apt update && sudo apt upgrade -y
		break;;
	[nN] ) echo "     Ok! Skipping update!"
		echo "       proceding with rest of script!"
		echo ""
		break;;
	* ) echo "     *****Not a valid responce! TISK!*****" ;;

esac
done

while true; do

read -p "Would you like to install boinc-client now? (y/n)" BOINC_INSTALL
echo""

case $BOINC_INSTALL in
	[yY] ) echo "     OK! proceding with install!"
		sudo apt install boinc-client -y
		break;;
	[nN] ) echo "     OK! Not installing boinc-client!"
		break;;
	* ) echo "   *****Not a valid responce! This would disappoint GOTSpectrum!*****" ;;
esac
done

# === ENABLE & START BOINC SERVICE ===
echo ""
echo "Enabling and starting boinc-client service..."
sudo systemctl enable boinc-client
sudo systemctl start boinc-client

# === ATTACH TO PROJECT ===
echo ""
echo "Attaching to BOINC project..."
boinccmd --project_attach "$PROJECT_URL" "$ACCOUNT_KEY"

# === CONFIGURE CPU USAGE ===

while true; do

echo ""
echo "Setting CPU percentage to script defaults of 75%"
read -p  "     Is this OK? (y/n)" CPU_PERCENT_SETUP

case $CPU_PERCENT_SETUP in
	[yY] ) echo "OK! using default CPU percentage!"
		break;;
	[nN] ) read -p "OK! What % for CPU usage? (0-100)" CPU_PERCENT
		break;;
	* ) echo "***Not a valid responce!!!***"

esac
done

while true; do

echo""
echo "Setting CPU usage to script default of 80%"
read -p "	Is this OK (y/n)" CPU_USAGE_LIMIT_SETUP

case $CPU_USAGE_LIMIT_SETUP in
	[yY] ) echo "OK! Using default CPU usage limit!"
		break;;
	[nN] ) read -p "OK! What % for CPU usage limit? (0-100)" CPU_USAGE_LIMIT
		break;;
	* ) echo "***Not a valid responce!!!***"

esac
done

echo""
echo "CPU set to $CPU_PERCENT%"
echo "CPU usage set to $CPU_USAGE_LIMIT"
sudo tee /var/lib/boinc-client/cc_config.xml >/dev/null <<EOF
<cc_config>
   <options>
      <max_ncpus_pct>${CPU_PERCENT}</max_ncpus_pct>
      <cpu_usage_limit>${CPU_USAGE_LIMIT}</cpu_usage_limit>
   </options>
</cc_config>
EOF

sudo systemctl restart boinc-client

# === ADD USER TO BOINC GROUP (optional) ===
echo ""
echo "Adding user '$USER_TO_ADD' to 'boinc' group..."
sudo usermod -aG boinc "$USER_TO_ADD"

echo ""
echo "✅ BOINC installation and configuration complete."
echo "➡️  Reboot or run: 'newgrp boinc' to apply group permissions."
echo "➡️  Use 'boinccmd --get_state' to check status."
echo ""
echo "Thank you for running GOTSpectrum's BOINC Install Script!"
