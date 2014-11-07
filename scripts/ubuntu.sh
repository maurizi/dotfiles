#!/bin/bash

# Essentials, can't run the install scripts without em
sudo apt-get install -qqy git stow python-setuptools python-dev build-essential
sudo easy_install pip

# Niceties - Integrates well with my oh-my-zsh plugins
sudo apt-get install -qqy tmux autojump

# ag isn't in the repos in precise, but it is in later versions
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
    curl --silent -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

sudo apt-get install -qqy ruby
echo "Installing hub"
if [ `lsb_release -cs` == "precise" ];
then
    sudo apt-get install -qqy rubygems
fi
sudo gem install -qy hub >/dev/null

source $(dirname $0)/common.sh
