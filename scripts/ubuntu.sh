#!/bin/bash

sudo apt-get install stow

sudo apt-get install tmux

if [ `lsb_release -cs` == "precise" ];
then
    sudo add-apt-repository ppa:mizuno-as/silversearcher-ag
    sudo apt-get update
fi
sudo apt-get install -qqy silversearcher-ag

# For tern
sudo apt-get install nodejs-legacy

if [ ! -e ~/.oh-my-zsh ];
then
    echo "Installing oh-my-zsh"
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

sudo apt-get install -qqy ruby
echo "Installing hub"
if [ `lsb_release -cs` == "precise" ];
then
    sudo apt-get install -qqy rubygems
fi
sudo gem install -qy hub >/dev/null

source $(dirname $0)/common.sh
