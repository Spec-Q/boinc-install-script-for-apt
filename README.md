# boinc-install-script-for-apt
A bash script to simplify the installation and set-up of the BOINC Client when operating in a headless(CLI) or Desktop Environment using APT

***Instructions for use***

  If you are inexperienced, please read these steps through fully before proceeding. These steps are provided as a guide and in my test cases this process proved successful. I'm happy for contributions to be made for the script or these instructions, as long as it is complient to the license. 

First step is to boot your computer running a Debian-based system with apt support. In my case, an Orange Pi 4A.

Once you have logged in and you see the terminal ready for your prompt, use the following command sequence. (If your machine has been running and in use, it may be ideal to navigate to you home directory simply by typing "cd" and hitting enter/return.)

sudo git clone https://github.com/Spec-Q/boinc-install-script-for-apt.git

This creates a folder named boinc-install-script-for-apt. Next, we need to navigate inside that folder with the next command. 

cd ~/boinc-install-script-for-apt

We now need to edit the scripts permissions using the chmod command.

sudo chmod +x /install_boinc.sh

The next step is to run the script, it will ask for the projects web address and your account key.
Then it will ask if you want to update your system and install the BOINC Client.
Have your project's web address and your account key ready to type or paste into the terminal.

sudo ./install_boinc.sh

Now you should be prompted to for the projects web address. Type or paste it into the terminal and press enter.
    Examples: https://www.primegrid.com   https://numberfields.asu.edu/NumberFields/   https://asteroidsathome.net/boinc/

Next you should be asked for your account key. The account key should be found in your acount with the project after signing up.
***Do not used the Cross-Project ID.***

Now you should be asked if you would like to update your computers packages and also install the BOINC Client.
Reccomended that you answer "y" if it has been while since updating packages

After that you should be asked how much of your CPU you would like to use and it's usage. This scripts defaults is currently set to 75% of cores and max load of 80% per core.

If all went well, you should now have the boinc client running on your system. To verify BOINC is running, use the following command

boinccmd --get_state

If you need further information on how to use the BOINC client in CLI, see here: https://github.com/BOINC/boinc/wiki/Boinccmd_tool



