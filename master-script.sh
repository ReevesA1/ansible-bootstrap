#!/usr/bin/env bash

# Install ansible + dependencies
packagesNeeded='git ansible'
if [ -x "$(command -v apt)" ]; then sudo apt install $packagesNeeded
elif [ -x "$(command -v pacman)" ]; then sudo pacman -S $packagesNeeded
elif [ -x "$(command -v dnf)" ]; then sudo dnf -S $packagesNeeded
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: $packagesNeeded">&2; fi


# Install Snap on Arch (with paru)
if [ -x "$(command -v pacman)" ]; then paru snapd
else pass; fi


#Make Directory

if [ "$(uname)" == "Darwin" ]; then
    mkdir /Users/rocket/bootstrap/
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    mkdir /home/rocket/bootstrap/
#elif [ "$(expr substr $(uname -s) 1 10)" == "Windows" ]; then
    # Do something under 32 bits Windows NT platform
fi


if [ "$(uname)" == "Darwin" ]; then
    cd /Users/rocket/bootstrap/
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    cd /home/rocket/bootstrap/
#elif [ "$(expr substr $(uname -s) 1 10)" == "Windows" ]; then
    # Do something under 32 bits Windows NT platform
fi



#Clone All scripts I run manualy 

if [ "$(uname)" == "Darwin" ]; then
    #base homebrew-packages
    wget https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Darwin/.base-homebrew.sh
    mv /Users/rocket/bootstrap/.base-homebrew.sh /Users/rocket/bootstrap/base-homebrew.command
    chmod u+x /Users/rocket/bootstrap/base-homebrew.command
    #base mas-packages
    wget https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Darwin/.base-mas.sh
    mv /Users/rocket/bootstrap/.base-mas.sh /Users/rocket/bootstrap/base-mas.command
    chmod u+x /Users/rocket/bootstrap/base-mas.command
    #Homebrew Nerdfonts
    wget https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Darwin/homebrew-nerdfonts.sh
    mv /Users/rocket/bootstrap/homebrew-nerdfonts.sh /Users/rocket/bootstrap/homebrew-nerdfonts.command
    chmod u+x /Users/rocket/bootstrap/homebrew-nerdfonts.command
    #Nuke
    wget https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/nuke-folder.sh
    mv /Users/rocket/bootstrap/nuke-folder.sh /Users/rocket/bootstrap/nuke-folder.command
    chmod u+x /Users/rocket/bootstrap/nuke-folder.command
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    wget https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/Linux/dash-to-dock.sh
    wget https://raw.githubusercontent.com/ReevesA1/ansible-bootstrap/main/nuke-folder.sh
#elif [ "$(expr substr $(uname -s) 1 10)" == "Windows" ]; then
    # Do something under 32 bits Windows NT platform
fi





#Give permission to bootstrap folder

if [ "$(uname)" == "Darwin" ]; then
    sudo chmod 775 /Users/rocket/bootstrap/
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    find $HOME/bootstrap -type f -print0 | xargs -0 chmod 775
#elif [ "$(expr substr $(uname -s) 1 10)" == "Windows" ]; then
    # Do something under 32 bits Windows NT platform
fi


##########################################DELETE RESIDU##########################################

#Delete master-script 

if [ "$(uname)" == "Darwin" ]; then
    rm /Users/rocket/master-script.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    rm /home/rocket/master-script.sh
#elif [ "$(expr substr $(uname -s) 1 10)" == "Windows" ]; then
    # Do something under 32 bits Windows NT platform
fi






#################################### Create Custom Facts##################################################
read -p "Are you sure you wish to create custom facts,type yes or no?"
if [ "$REPLY" != "yes" ]; then
   exit
fi



sudo mkdir /etc/ansible/
sudo mkdir /etc/ansible/facts.d/ && sudo chown rocket /etc/ansible/facts.d/

if [ "$(uname)" == "Darwin" ]; then
    touch /etc/ansible/facts.d/custom.fact 
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    touch /etc/ansible/facts.d/custom.fact
#elif [ "$(expr substr $(uname -s) 1 10)" == "Windows" ]; then
    # Do something under 32 bits Windows NT platform
fi


#Make sure the file is not executable as this will break the ansible.builtin.setup module.
sudo chmod -x /etc/ansible/facts.d/custom.fact




# Append Custom fact pertaining to machines

if [ "$(uname)" == "Darwin" ]; then
    {
        echo '[env]'
        echo 'desktop = skip'
        echo 
        echo '[role]'
        echo 'machine = daily-driver'
        echo
        echo '[device]'
        echo 'dev = skip' 

} >> /etc/ansible/facts.d/custom.fact
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    {
        echo '[env]'
        echo 'desktop = gnome or kde'
        echo 
        echo '[role]'
        echo 'machine = daily-driver or server'
        echo
        echo '[device]'
        echo 'dev = rogstrix-lap or rogstrix-desk or steamdeck' 
} >> /etc/ansible/facts.d/custom.fact
#elif [ "$(expr substr $(uname -s) 1 10)" == "Windows" ]; then
    # Do something under 32 bits Windows NT platform
fi


