#!/bin/bash

sudo apt-get install stow

sudo apt-get install tmux

sudo apt-get install -qqy silversearcher-ag

# For tern
sudo apt-get install nodejs-legacy

if [ ! -e ~/.oh-my-zsh ];
then
    echo "Installing oh-my-zsh"
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

echo "Installing hub"
sudo apt-get install -qqy ruby
sudo gem install -qy hub >/dev/null

source $(dirname $0)/common.sh
