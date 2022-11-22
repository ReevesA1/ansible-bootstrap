# Reformat FYI's 
- Make sure my user is allways rocket for scripts to work (mac and linux for sure)

# FYI's
### Fonts
- install nerd fonts with the entire library on nextcloud or clone the repo from https://github.com/ryanoasis/nerd-fonts and ./install

## HELP (pull not working) Common Fixes 
- Most of the time its permissions. if I'm restructering pay attention at how the become:true and become_user were implemented
- Git module = make sure the source http link I'm cloning ends with .git 

# Commands
### line to Gather facts
- `ansible localhost -m gather_facts | grep ansible_distribution`
### line to gather custom facts
- `ansible localhost -m setup -a 'gather_subset=!all,!min,virtual' -a filter=ansible_local`
### my custom facts conditions
- `when: ansible_local['custom']['env']['desktop'] in ["gnome"]` --> or kde 
- `when: ansible_local['custom']['device']['dev'] in ["mac"]`   -- > or rogstrix-lap, rogstrix-desk
- `when: ansible_local['custom']['role']['machine'] in ["daily-driver"]`  --> or server


# Manual Setup

### Arch
- Must install Snap manualy, if paru is installed like garuda the initilising script command bellow will install it
  
### Fedora
-  delete the first section of native bashrc file for bash to work  (SHOULD NOT MATTER ANYMORE I OVER WRITE NATIVE BASH AND ZSH FILES NOW INSTEAD OF APPENDING SOURCES)
	``` # Source global definitions
   	 if [ -f /etc/bashrc ]; then
	. /etc/bashrc
    	fi ``` 

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


# LASTLY, Run ansible pull

### OLD - As a Public Repo
- `sudo ansible-pull -U https://github.com/ReevesA1/ansible.git -vv`
### NEW - As  a Private Repo
- `sudo ansible-pull -U https://ReevesA1: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@github.com/ReevesA1/ansible.git -vv`

# Post Playbook Run
- ** After REBOOT SYSTEM!!! or flatpaks won't show, and shell wont change to zsh **
- open neovim and run `:PlugInstall` sometimes it installes it by itself????


