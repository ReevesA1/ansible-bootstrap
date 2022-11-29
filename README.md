# Setting UP the DISTRUBUTION 
- No matter what OS Im using make sure my username is "rocket"
- Make sure it is updated `sudo apt update` or packages won't get installed

### Arch
- Must install Snap manualy, if paru is installed like garuda the initilising script command bellow will install it
  

### Windows 
- Install Ansible preferably with `winget install -e --id Cygwin.Cygwin` if not  `choco install cygwin`

### Mac 
- Install xcode-command-line-tools
	- `xcode-select --install` 
- Install Homebrew
- ```/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"```
  - Run these 2 Commands to Add Path
   	- ```echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/rocket/.zprofile```
   	- ```eval "$(/opt/homebrew/bin/brew shellenv)"```
  - Install `brew bundle`
      
- Turn off google analytics `brew analytics off`
- Install wget to pull the script below
	- `brew install wget`
	- `brew install ansible`
- Disable Mac gate keeper
	- `sudo spctl --master-disable`
  

### Parallels Ubuntu
- First BEFORE RUNNING THE SCRIPT
  - CHANGE KEY BINDINGS
    - Top Bar --> Device --> Keyboard --> customize --> click on Ubuntu in left pane 
      - at the bottom hit the + button and straight up add from mac single "command button" and to Linux single "control button" 
  - Make "my_normal_user" Account
	- as the parallel user create a new Admin User with the GUI then log out and log back in as that "new_normal_user"
    	- also enable log in automaticaly
	-  Change complex password to simple 
   	    -  go to `sudo gedit /etc/pam.d/common-password` and overwrite the  bottom section with the code below. 
   	    -  Once changed use the `passwd` command to change to my normal password.
	- Update with `sudo apt update && sudo apt upgrade` it will ask to overwrite "pam password file" choose no 
	- delete old parallel User from GUI
  
  
	``` # here are the per-package modules (the "Primary" block)
	   	password	[success=1 default=ignore]	pam_unix.so minlen=4 sha512
	   	# here's the fallback if no module succeeds
	   	password	requisite			pam_deny.so
	   	# prime the stack with a positive return value if there isn't one already;
		# this avoids us returning an error just because nothing sets a success code
		# since the modules above will each just jump around	
		password	required			pam_permit.so
		# and here are more per-package modules (the "Additional" block)
		password	optional	pam_gnome_keyring.so 
		# end of pam-auth-update config 

- AFTER RUNNING THE MAIN SCRIPT RUN
  -  (LAST TIME I DID NOT HAVE TO DO  `sudo apt remove ansible`)
  -  (Next time try without this) `sudo apt install pip && pip install ansible`
  -  when I run I get an error at a cargo command so I thought to  `sudo apt install cargo` (NEVER MIND THIS IS AN ERROR WITH ANSIBLE cause cargo will get installed with ansible pull)
     -  I trie this `echo "export PATH="/home/rocket/.local/bin:$PATH"" >> $HOME/.bashrc`

  

# Download & Run Bootstrap Scripts


- `wget https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/master-script.sh && find $HOME/master-script.sh  -type f -print0 | xargs -0 chmod 775 && ./master-script.sh`




# Run desired scripts 

- dash-to-dock for Gnome (not needed on ubuntu)
    - Must do a restart before it can be enabled!
    - Enable it manually! with this command `gnome-extensions enable dash-to-dock@micxgx.gmail.com`



# Set Custom Facts

- Edit Custom facts if need be
    - Linux  `nano /etc/ansible/facts.d/custom.fact`
    - Mac `open -e /etc/ansible/facts.d/custom.fact` 


