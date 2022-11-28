#!/usr/bin/env bash


#                 
#                       .888
#                     .8888'
#                    .8888'
#                    888'
#                    8'
#       .88888888888. .88888888888.
#    .8888888888888888888888888888888.
#  .8888888888888888888888888888888888.
#  .&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
# &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
# `%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
#  `00000000000000000000000000000000000'
#   `000000000000000000000000000000000'
#    `0000000000000000000000000000000'
#      `###########################'
#        `#######################'
#          `#########''########'
#            `""""""'  `"""""'
#



#FYI if having issues installing apps I can try to force using different architectures
#  `arch -arm64 brew install --cask nameofapp`
##################################          INSTALL      #################################


#Casks's 	


#IMPORTANT
brew install --cask barrier
brew install --cask nextcloud	

#Security
brew install --cask protonvpn
brew install --cask authy # Moving forward I only want authy on apple stuff
brew install --cask lulu
brew install --cask zerotier-one

#Browsers
brew install --cask firefox	
brew install --cask librewolf

#Terminals
brew install --cask iterm2
brew install --cask warp # Rust Based Terminal
brew install --cask cool-retro-term

#Media
brew install --cask sonoair
brew install --cask spotify
brew install --cask plex-media-player

# Hypervisors
brew install --cask parallels #need to allow iterm permission pop up so it works



#Utilities
brew install --cask alfred
brew install --cask raycast # another launcher
brew install --cask appcleaner
brew install --cask onyx
brew install --cask vlc
brew install --cask the-unarchiver
brew install --cask flameshot



#Hotkeys and dock
brew install --cask amethyst
brew install --cask thor
brew install --cask icanhazshortcut
brew install --cask rectangle

#Productivity
brew install --cask todoist
brew install --cask notion

#Coding
brew install --cask visual-studio-code
brew install --cask github #github desktop
brew install --cask godot


# Social 
brew install --cask session #Onion routing based messenger
brew install --cask messenger
brew install --cask discord

# $ Paid Apps
brew install --cask macupdater # not on set app
brew install --cask setapp ####### ALL THESE COULD BE REPLACED WITH setapp $$$ MONTHLY
#brew install --cask memory-cleaner # did not work (nov 2022)
brew install --cask dropzone
brew install --cask bartender # bought a license

#hacking
brew install --cask altserver


#######################################   NOT CASK'S    ###########################################

#Important
brew install topgrade
brew install neovim
brew install fail2ban
brew install mas
brew install starship

## Oh My zsh
brew install zsh-syntax-highlighting
brew install zsh-autosuggestions



## Misc
brew install curl
brew install wget
brew install bat
brew install fd
brew install fzf
brew install ripgrep
brew install youtube-dl
brew install zoxide
brew install exa
brew install xclip
brew install make
brew install node
brew install htop
brew install bpytop
brew install neofetch
brew install gedit
brew install figlet
brew install cmatrix
brew install joplin-cli
brew install trash
brew install tldr
brew install bash
brew install git
brew install colordiff
brew install shellcheck
brew install autojump
brew install rustup-init





##################################        DON'T  INSTALL      #################################

# APPS I Prolly won't use moving forward but good to keep for reference

#FYI Nextcloud replaced Insync
#brew install --cask insync 

#Downloaders (I Download on windows server)
#brew install --cask jdownloader
#brew install --cask qbittorrent

#Browsers (just use safari and arc)
#brew install --cask microsoft-edge
#brew install --cask tor-browser


#Gaming (not going to game on mac)
#brew install --cask epic-games
#brew install --cask steam
#brew install --cask heroic
#brew install --cask itch
#brew install --cask retroarch
#brew install --cask nvidia-geforce-now

#Productivity (Don't really need with main machine right here, could be useful on a mac laptop)
#brew install --cask neovide
#brew install --cask mark-text
#brew install --cask sleek
#brew install --cask onlyoffice
#brew install --cask krita
#brew install --cask joplin
#brew install --cask logseq
#brew install --cask obsidian



#Social (Don't really need with main machine right here, could be useful on a mac laptop)
#brew install --cask signal
#brew install --cask telegram-desktop



# Display Manager (i dont really share the display anymore)
#brew install --cask betterdisplay # if not manualy install lunar cause brew doesnt work for it

#Misc (Don't really need with main machine right here, could be useful on a mac laptop)
#brew install --cask sweet-home3d
#brew install --cask balenaetcher
#brew install --cask raspberry-pi-imager
#brew install --cask nitroshare
#brew install --cask kindle
#brew install --cask vscodium # I use the official one way better with plugins
#brew install --cask bluestacks


# Only if making server
#brew install --cask plex-media-server
#brew install --cask jellyfin

#Ferdium act as Email client --> UPDATE NOW I KNOW I CAN ADD ALL ACCOUNTS TO NATIVE MAIL APP DONT NEED FERDIUM!!!
#brew install --cask ferdium

#Media 
#brew install --cask kodi



#Not tested yet
#brew install --cask stremio

#Not using yet
#brew install --cask bitwarden
#brew install --cask rustdesk #fyi does not work with vpn on


#Security
# brew install --cask little-snitch # Lulu is apparently better and free

# Utility
#brew install --cask hiddenbar # I dont use because on my m2 mac laptop the camera notch hides icons and bartender is the only one that can fix it
#brew install --cask roboform # not like the windows app, this just adds extensions to browsers that i can do manualy

