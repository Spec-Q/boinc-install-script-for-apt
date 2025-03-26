# boinc-install-script-for-atp
A bash script to simplify the installation and set-up of the BOINC Client when operating in a headless(CLI) or Desktop Environment using APT

Instructions for use, if you are inexperienced, please read these steps through fully before proceeding. These steps are provided as a guide and in my test cases this process proved successful. I'm happy for contributions to be made for the script or these instructions, as long as it is complient to the license. 

First step is to boot your computer running a Debian-based system with apt support. In my case, an Orange Pi 4A.

Once you have logged in and you see the terminal ready for your prompt, use the following command sequence. (If your machine has been running and in use, it may be ideal to navigate to you home directory simply by typing "cd" and hitting enter/return.)

sudo git clone https://github.com/Spec-Q/boinc-install-script-for-apt.git

This creates a folder named boinc-install-script-for-apt. Next, we need to navigate inside that folder with the next command. 

cd ~/boinc-install-script-for-apt

We now need to edit the script so you can select your project and enter your account key. 

sudo nano install_boinc.sh

You will need to edit two lines at the top of the document. 

"PROJECT_URL="https://www.worldcommunitygrid.org"   # <- Change to your project" (Change the project URL to the project you would like to contribute towards)

"ACCOUNT_KEY="REPLACE_WITH_YOUR_ACCOUNT_KEY"        # <- Replace with your actual key" (Change with your account key found on the account page at the projects website)

After editing the two lines use the following shortcuts to save the changes. 

Press Ctrl + X to exit
Press Y to confirm changes
Press Enter to save

We then need to make the script executable using chmod. 

sudo chmod +x /install_boinc.sh

The final step is to run the script, which should automatically update your system, install the client, and get it configured to run the project you specified. 

sudo ./install_boinc.sh

If all went well, you should now have the boinc client running on your system. To verify BOINC is running, use the following command

boinccmd --get_state

If you need further information on how to use the BOINC client in CLI, see here: https://github.com/BOINC/boinc/wiki/Boinccmd_tool



