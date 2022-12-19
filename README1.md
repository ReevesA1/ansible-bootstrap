# Setting UP the DISTRUBUTIONS with ANSIBLE 
- No matter what OS Im using make sure my username is "rocket"
- Make sure it is updated `sudo apt update` or packages won't get installed



# Linux 

```
    _nnnn_
        dGGGGMMb
       @p~qp~~qMb
       M|@||@) M|
       @,----.JM|
      JS^\__/  qKL
     dZP        qKRb
    dZP          qKKb
   fZP            SMMb
   HZM            MMMM
   FqM            MMMM
 __| ".        |\dS"qML
 |    `.       | `' \Zq
_)      \.___.,|     .'
\____   )MMMMMP|   .'
     `-'       `--' hjm
```

## Arch
- Must install Snap manualy, if paru is installed like garuda the initilising script command bellow will install it


# Windows 

```
                   .oodMMMMMMMMMMMMM
       ..oodMMM  MMMMMMMMMMMMMMMMMMM
 oodMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
 
 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
 MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
 `^^^^^^MMMMMMM  MMMMMMMMMMMMMMMMMMM
       ````^^^^  ^^MMMMMMMMMMMMMMMMM
                      ````^^^^^^MMMM
```
## ultimate-win-bootstrap.ps1 (NO Ansible)

### First step
- CHANGE PC NAME!!!!

### Setup Latest PowerShell 
- Install Winget with the latest version of Powershell. ( I think winget is installed by default? if not add that section here as well as in script)
  - FYI I need to use winget to allow the installation of modules, because choco wouldn’t because of where the directory is stored under choco?.
  - FYI I thought that admin wouldnt be able to see and use my $profile but it does recognise it!!!!
  - `winget install Microsoft.PowerShell`
### Windows Terminal Setup
- Make Powershell 7 Default Shell (don't make it open as admin) + change the color to "Campbell Powershell" 
- Delete profiles that I dont want like Azure profile and Old Powershell
- Cygwin Add to Windows Terminal (video in notion if I forget) 

### Install Modules

-  Install PSWindowsUpdate Module
```
.{
Install-Module PSWindowsUpdate
Add-WUServiceManager -MicrosoftUpdate
} 
```

- Always Run `winget upgrade --all`
- Then In the Latest Powershell

```
.{
$ScriptFromGithHub = Invoke-WebRequest https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Windows/ultimate-win-bootstrap.ps1
Invoke-Expression $($ScriptFromGithHub.Content)
}
```

## Ansible WSL Method (Works)
FYI I have to make custom facts file manualy (i only tested "skip" fact on all of them--> could make a script to automate that)
FYI eveything is contained inside the WSL distro and I can't manipulate windows at all

STEPS
- search for Turn Windows features on or off and turn on Windows Subsystem for Linux & Virtual Machine Platform or use the commands below
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```
- restart machine
- go to windows store and download Newest Ubuntu
- might have to get kernal file here (works for arm and X64) https://learn.microsoft.com/en-ca/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package
- On Apple Silicone Chips "ARM" I have to run WSL1 so in powershell as Admin
	- `wsl --set-default-version 1` 
- Install ansible
	- `sudo apt update && sudo apt upgrade`
	- `sudo apt-get install software-properties-common`
	- `sudo apt-add-repository ppa:ansible/ansible`
	- `sudo apt-get update`
	- `sudo apt-get install ansible git -y`





# Mac  

```
                       .888
                     .8888'
                    .8888'
                    888'
                    8'
       .88888888888. .88888888888.
    .8888888888888888888888888888888.
  .8888888888888888888888888888888888.
 .&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
 &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
 &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
 `%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
 `00000000000000000000000000000000000'
  `000000000000000000000000000000000'
   `0000000000000000000000000000000'
     `###########################'
       `#######################'
         `#########''########'
           `""""""'  `"""""'
```

## Mac Homebrew file Dump Method
- Install xcode-command-line-tools
	- `xcode-select --install` 
- Install Homebrew
- ```/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"```
  - Run these 2 Commands to Add Path
   	- ```echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/rocket/.zprofile```
   	- ```eval "$(/opt/homebrew/bin/brew shellenv)"```
  - Install `arch -arm64 brew bundle`
      
- Turn off google analytics `brew analytics off`
- Install wget to pull the script below
	- `arch -arm64 brew install wget`
	- `arch -arm64 brew install ansible` # Could also install with python if I run into issues
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
  
# Universal

```

#                        .,,uod8B8bou,,.
#               ..,uod8BBBBBBBBBBBBBBBBRPFT?l!i:.
#          ,=m8BBBBBBBBBBBBBBBRPFT?!||||||||||||||
#          !...:!TVBBBRPFT||||||||||!!^^""'   ||||
#          !.......:!?|||||!!^^""'            ||||
#          !.........||||                     ||||
#          !.........||||  ##                 ||||
#          !.........||||                     ||||
#          !.........||||                     ||||
#          !.........||||                     ||||
#          !.........||||                     ||||
#          `.........||||                    ,||||
#           .;.......||||               _.-!!|||||
#    .,uodWBBBBb.....||||       _.-!!|||||||||!:'
# !YBBBBBBBBBBBBBBb..!|||:..-!!|||||||!iof68BBBBBb....
# !..YBBBBBBBBBBBBBBb!!||||||||!iof68BBBBBBRPFT?!::   `.
# !....YBBBBBBBBBBBBBBbaaitf68BBBBBBRPFT?!:::::::::     `.
# !......YBBBBBBBBBBBBBBBBBBBRPFT?!::::::;:!^"`;:::       `.
# !........YBBBBBBBBBBRPFT?!::::::::::^''...::::::;         iBBbo.
# `..........YBRPFT?!::::::::::::::::::::::::;iof68bo.      WBBBBbo.
#   `..........:::::::::::::::::::::::;iof688888888888b.     `YBBBP^'
#     `........::::::::::::::::;iof688888888888888888888b.     `
#       `......:::::::::;iof688888888888888888888888888888b.
#         `....:::;iof688888888888888888888888888888888899fT!
#           `..::!8888888888888888888888888888888899fT|!^"'
#             `' !!988888888888888888888888899fT|!^"'
#                 `!!8888888888888888899fT|!^"'
#                   `!988888888899fT|!^"'
#                     `!9899fT|!^"'
#                       `!^"'
# 

```


## Download & Run Bootstrap Scripts


- `wget https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/master-script.sh && find $HOME/master-script.sh  -type f -print0 | xargs -0 chmod 775 && ./master-script.sh`




## Run desired scripts 

- dash-to-dock for Gnome (not needed on ubuntu)
    - Must do a restart before it can be enabled!
    - Enable it manually! with this command `gnome-extensions enable dash-to-dock@micxgx.gmail.com`



## Set Custom Facts

- Edit Custom facts if need be
    - Linux  `nano /etc/ansible/facts.d/custom.fact`
    - Mac `open -e /etc/ansible/facts.d/custom.fact` 


