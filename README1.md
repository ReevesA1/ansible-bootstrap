# Setting UP the DISTRUBUTION 
- No matter what OS Im using make sure my username is "rocket"
- Make sure it is updated `sudo apt update` or packages won't get installed


################################################################
##                   Linux                                    ##
################################################################
#    _nnnn_
#        dGGGGMMb
#       @p~qp~~qMb
#       M|@||@) M|
#       @,----.JM|
#      JS^\__/  qKL
#     dZP        qKRb
#    dZP          qKKb
#   fZP            SMMb
#   HZM            MMMM
#   FqM            MMMM
# __| ".        |\dS"qML
# |    `.       | `' \Zq
#_)      \.___.,|     .'
#\____   )MMMMMP|   .'
#     `-'       `--' hjm
#

## Arch
- Must install Snap manualy, if paru is installed like garuda the initilising script command bellow will install it

################################################################
##                   Windows                                ##
################################################################

#                   .oodMMMMMMMMMMMMM
#       ..oodMMM  MMMMMMMMMMMMMMMMMMM
# oodMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
# MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
# MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
# MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
# MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
# MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
# 
# MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
# MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
# MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
# MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
# MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
# `^^^^^^MMMMMMM  MMMMMMMMMMMMMMMMMMM
#       ````^^^^  ^^MMMMMMMMMMMMMMMMM
#                      ````^^^^^^MMMM


## Windows
- https://phoenixnap.com/kb/install-ansible-on-windows

### Install Choco (all methods need it)
```
	 # Ensure chocolatey installed
if ([bool](Get-Command -Name 'choco' -ErrorAction SilentlyContinue)) {
    Write-Verbose "Chocolatey is already installed, skip installation." -Verbose
}
else {
    Write-Verbose "Installing Chocolatey..." -Verbose
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} 
```
### WSL Method

- search for Turn Windows features on or off and turn on Windows Subsystem for Linux & Virtual Machine Platform 
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```
- restart machine
- go to windows store and download Newest Ubuntu
- might have to get kernal file here (works for arm and X64) https://learn.microsoft.com/en-ca/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package
- On Apple Silicone Chips I have to run WSL1 so in powershell as Admin
	- `wsl --set-default-version 1` 
- `sudo apt update && sudo apt upgrade`
- `sudo apt-get install software-properties-common`
- `sudo apt-add-repository ppa:ansible/ansible`
- `sudo apt-get update`
- `sudo apt-get install ansible -y`
- `sudo apt install git ansible`
- Maybe need to add this `ansible-galaxy collection install ansible.windows` or I need a requirements.yml file with all the windows collections

### Cygwin Method (I think cygwin choco or the exe install ansible 2.8 )
- Install Ansible preferably with Choco could not figure out winget version
	- `choco install cygwin` and get the package manager `choco install cyg-get`
- TEST `cyg-get git` then `cyg-get git` 
- if that doesn't work I have to install it manually from the exe https://cygwin.com/setup-x86_64.exe


### Python Method (is this the Windows rm  ( not really for Ansible pull ) method?)
- Install python 3.10 with the microsoft store
- Fix [WinError 206] The filename or extension is too long with one of three methods (https://www.youtube.com/watch?v=obJmcid_erI) 
	-I choose the one below 
	- `Reggedit go to Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem` then in LongPathsEnabled and change the 0 to 1
- in Command prompt (not sure if it also works in powershel) run these commands
	- `pip3 install --upgrade pip`
	- `pip3 install ansible`

- add python to path 
	- Open up the Control Panel and navigate to System and Security > System
	- Click on the Advanced system settings link on the left panel
	- Click Environment Variables.
	- Under System Variables, double-click the variable PATH.
	- Click New, and add the directory where pip is installed, e.g. C:Python33Scripts, and select OK.
	- `C:\Users\rocket\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.10_qbz5n2kfra8p0\LocalCache\local-packages\Python310\Scripts`

- More python shit
	- `sudo apt install python3-pip`
	- `sudo pip3 install pywinrm`
	- `sudo pip3 install pyvmomi`
	- `sudo pip3 install ansible`
	- `sudo pip3 install ansible[azure]`


###############################################################
##                  Mac                                   ##
################################################################

#                       .888
#                     .8888'
#                    .8888'
#                    888'
#                    8'
#       .88888888888. .88888888888.
#    .8888888888888888888888888888888.
#  .8888888888888888888888888888888888.
# .&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
# `%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
# `00000000000000000000000000000000000'
#  `000000000000000000000000000000000'
#   `0000000000000000000000000000000'
#     `###########################'
#       `#######################'
#         `#########''########'
#           `""""""'  `"""""'
#

## Mac 
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
  

## Parallels Ubuntu
- First BEFORE RUNNING THE SCRIPT
  - CHANGE KEY BINDINGS
    - Top Bar --> Device --> Keyboard --> customize --> click on Ubuntu in left pane 
      - at the bottom hit the + button and straight up add from mac single "command button" and to Linux single "control button"  ONLY HAVE TO DO THIS ONCE!
  - Make "my_normal_user" Account
	- as the parallel user create a new Admin User with the GUI then log out and log back in as that "new_normal_user"
    	- also enable log in automaticaly
	-  Change complex password to simple 
   	    -  go to `sudo gedit /etc/pam.d/common-password` and overwrite the  bottom section with the code below. 
   	    -  Once changed use the `passwd` command to change to my normal password.
	- Update with `sudo apt update && sudo apt upgrade` it will ask to overwrite "pam password file" choose NO!!!S 
	- delete old parallel User from GUI
  
  
	```
	 # here are the per-package modules (the "Primary" block)
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

	```

- AFTER RUNNING THE MAIN SCRIPT RUN
  -  `sudo apt remove ansible`
  -  (Next time try without this) `sudo apt install pip && sudo pip install ansible` FUCKING MAKE SURE THESE BOTH HAVE SUDO
  

  

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


