#!/usr/bin/env bash

# Not using this file since I have paru build snapd with initial manual script with paru

git clone https://aur.archlinux.org/snapd.git /home/rocket/Downloads/snapd/
cd /home/rocket/Downloads/snapd
makepkg -si --noconfirm 
