#!/usr/bin/env bash

# first make sure we have a python env we can use

exe=`type -path -all "virtualenv" | head -n 1`

if [ ! -x "$exe" ]; then
    echo "Please install your operating system\'s Python 3.x virtualenv package"
    exit 1
fi

# now we install the virtualenv
virtualenv $HOME/.python3

# activate the new virtualenv
source $HOME/.python3/bin/activate

# install powerline into our virtualenv
$HOME/.python3/bin/pip3 install powerline-status

# install my powerline mods
if [ -d powerline-status-histcmd ]; then
    cd ./powerline-status-histcmd
    $HOME/.python3/bin/pip3 install ./
else
    echo 'No powerline-status-histcmd dir found. Skipping powerline-status-histcmd installation.'
fi
