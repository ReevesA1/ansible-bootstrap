#!/usr/bin/env bash

# For Security reasons I will not put my private Repo info here
# FYI to Run this script on mac zsh I must use this command `bash ./cp-ansible-pull.sh` or it won't run

if [ "$(uname)" == "Darwin" ]; then
    echo "sudo ansible-pull -U https://github.com/ReevesA1/ansible.git -vv" | pbcopy
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo "sudo ansible-pull -U https://github.com/ReevesA1/ansible.git -vv" | xclip -sel clip
#elif [ "$(expr substr $(uname -s) 1 10)" == "Windows" ]; then
    # Do something under 32 bits Windows NT platform
fi