#!/bin/bash

# Boinc install script V0.1.5(BETA) for Debian based systems. This was tested on a Orange Pi 4A, please leave me feedback by contacting me on one of the platforms below. 
# Created by Spec,GOTSpectrum(LTT Forum), @gotspectrum.bsky.social, https://github.com/Spec-Q

# === CONFIGURATION ===
PROJECT_URL="https://www.worldcommunitygrid.org"   # <- Change to your project
ACCOUNT_KEY="REPLACE_WITH_YOUR_ACCOUNT_KEY"        # <- Replace with your actual key
CPU_PERCENT=75.0                                   # % of cores to use
CPU_USAGE_LIMIT=80                                 # Max % CPU load per core
USER_TO_ADD="$USER"                                # Add current user to 'boinc' group

# === UPDATE & INSTALL ===
echo "Updating package lists and installing boinc-client..."
sudo apt update && sudo apt upgrade -y
sudo apt install boinc-client -y

# === ENABLE & START BOINC SERVICE ===
echo "Enabling and starting boinc-client service..."
sudo systemctl enable boinc-client
sudo systemctl start boinc-client

# === ATTACH TO PROJECT ===
echo "Attaching to BOINC project..."
boinccmd --project_attach "$PROJECT_URL" "$ACCOUNT_KEY"

# === CONFIGURE CPU USAGE ===
echo "Setting CPU usage limits..."
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
echo "Adding user '$USER_TO_ADD' to 'boinc' group..."
sudo usermod -aG boinc "$USER_TO_ADD"

echo
echo "✅ BOINC installation and configuration complete."
echo "➡️  Reboot or run: 'newgrp boinc' to apply group permissions."
echo "➡️  Use 'boinccmd --get_state' to check status."