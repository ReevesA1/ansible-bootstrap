# Manual Setup

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
    
- WTF THIS NEXT LINE I CANT GET TO WORK YET? But topgrade isnt even telling me it needs it so maybe skip it next time?
    - Instal rust & cargo
        - `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh` # https://www.rust-lang.org/tools/install
            - then source it for current shell 
                - `source "$HOME/.cargo/env"` then `sudo cargo install cargo-update`


# Manual Scripts to Initialise First

### OLD - As a Public Repo
- `wget https://raw.githubusercontent.com/ReevesA1/ansible/main/tasks/bootstrap/manual/master-script.sh && find $HOME/master-script.sh  -type f -print0 | xargs -0 chmod 775 && ./master-script.sh`

### NEW - As  a Private Repo ( NO GO)
- No Go because the token line below changes everytime I make a commit
- `wget https://raw.githubusercontent.com/ReevesA1/ansible/main/tasks/bootstrap/manual/master-script.sh?token=GHSAT0AAAAAAB2MTFQOXNV6IFITEXEJ4QPCY32VUXA && find $HOME/master-script.sh?token=GHSAT0AAAAAAB2MTFQOXNV6IFITEXEJ4QPCY32VUXA  -type f -print0 | xargs -0 chmod 775 && ./master-script.sh?token=GHSAT0AAAAAAB2MTFQOXNV6IFITEXEJ4QPCY32VUXA`
- I must `wget` the RAW!!! command manualy from here https://github.com/ReevesA1/ansible/blob/main/tasks/bootstrap/manual/master-script.sh
- Once downloaded change the name to `master-script.sh` then in the same directory run the next command in terminal
- `find $HOME/master-script.sh  -type f -print0 | xargs -0 chmod 775 && ./master-script.sh`


- Then Run desired scripts 
    - If installing dash-to-dock for Gnome (not needed on ubuntu), must do a restart before it can be enabled!
        - Enable it manually!
            - `gnome-extensions enable dash-to-dock@micxgx.gmail.com`


# Set Custom Facts

- Edit Custom facts if need be
    - Linux  `nano /etc/ansible/facts.d/custom.fact`
    - Mac `open -e /etc/ansible/facts.d/custom.fact` 


# Fonts
- install nerd fonts with the entire library on nextcloud or clone the repo from https://github.com/ryanoasis/nerd-fonts and ./install