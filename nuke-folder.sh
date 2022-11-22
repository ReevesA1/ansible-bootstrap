#!/usr/bin/env bash


if [ "$(uname)" == "Darwin" ]; then
    rm -vrf /Users/rocket/bootstrap
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    rm -vrf /home/rocket/bootstrap
#elif [ "$(expr substr $(uname -s) 1 10)" == "Windows" ]; then
    # Do something under 32 bits Windows NT platform
fi