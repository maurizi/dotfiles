#!/bin/bash

sudo apt-get install -qqy stow
sudo apt-get install -qqy tmux
sudo apt-get install -qqy git
sudo apt-get install -qqy python-setuptools python-dev build-essential
sudo easy_install pip

if [ `lsb_release -cs` == "precise" ];
then
    sudo add-apt-repository -y ppa:lvillani/silversearcher
    sudo apt-get update
fi
sudo apt-get install -qqy silversearcher-ag

if [ ! -e ~/.oh-my-zsh ];
then
    sudo apt-get install -qqy curl zsh
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
