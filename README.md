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
- Turn off google analytics `brew analytics off`
- Install wget to pull the script below
	- `brew install wget`
	- `brew install ansible`
- Disable Mac gate keeper
	- `sudo spctl --master-disable`
  

### Parallels 
- after the main script run I have to `sudo apt remove ansible` and then install it with pip `sudo apt install pip && pip install ansible`
- Also I have to run `ansible-pull` with `--tags parallels` 
- Ubuntu Keyboard Shortcut in Parallels Preference under the VM I want changed under shortcuts
		change Command to Control 

- Make "rocket" Account
	- as the parallel user create a new Admin User with the GUI then log out and log back in as rocket
	- changing complex password to simple go to `sudo gedit /etc/pam.d/common-password` and the bottom section should look like this
  
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
		# end of pam-auth-update config ```


# Download Bootstrap Scripts


- `wget https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/master-script.sh && find $HOME/master-script.sh  -type f -print0 | xargs -0 chmod 775 && ./master-script.sh`




# Run desired scripts 

- dash-to-dock for Gnome (not needed on ubuntu)
    - Must do a restart before it can be enabled!
    - Enable it manually! with this command `gnome-extensions enable dash-to-dock@micxgx.gmail.com`

- Brew_apps script
	- First run Parallels will fail because I must accept the little iterm2 pop up and run it again


# Set Custom Facts

- Edit Custom facts if need be
    - Linux  `nano /etc/ansible/facts.d/custom.fact`
    - Mac `open -e /etc/ansible/facts.d/custom.fact` 


# Fonts
- install nerd fonts with the entire library on nextcloud or clone the repo from https://github.com/ryanoasis/nerd-fonts and ./install
