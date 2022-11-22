#!/usr/bin/env bash

# Fyi's
# Ive tried using ansible to automate this, I couldnt get it to work (having to restart after would cause issues anyway)

# `flatpak install flathub com.mattjakeman.ExtensionManager`


######install sassc depending on package manager



packagesNeeded='sassc'
if [ -x "$(command -v dnf)" ]; then sudo dnf install $packagesNeeded
elif [ -x "$(command -v pacman)" ]; then sudo pacman -S $packagesNeeded
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: $packagesNeeded">&2; fi





##################################

git clone https://github.com/micheleg/dash-to-dock.git
sleep 3
cd /home/rocket/bootstrap/dash-to-dock
sleep 3
export SASS=sassc
sleep 3
make
sleep 3
make install
sleep 3
echo "Restart PC for extension to work then enable it with" 
echo "gnome-extensions enable dash-to-dock@micxgx.gmail.com"
echo "or enable int with the extension manager, flatpak"

# can change some preferences with this line
#gnome-shell-extension-prefs dash-to-dock@micxgx.gmail.com


## Tried to automate --> Enable extension I build from source (does not work, must do it manualy following steps in readme)
#- name: enable dash to dock extension
#  become_user: rocket
#  ansible.builtin.command: 
#    cmd: gnome-extensions enable dash-to-dock@micxgx.gmail.com
#  when: ansible_distribution in ["Fedora"]