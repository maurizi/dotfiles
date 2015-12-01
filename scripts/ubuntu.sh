#!/bin/bash

set -e

# ag isn't in the repos in precise, but it is in later versions
if [ `lsb_release -cs` == "precise" ];
then
    sudo add-apt-repository -y ppa:lvillani/silversearcher
fi
# Neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable

sudo apt-get update

# Essentials, can't run the install scripts without em
sudo apt-get install -qqy git stow python-setuptools python-dev build-essential python-software-properties
sudo easy_install pip

# Niceties - Integrates well with my oh-my-zsh plugins
sudo apt-get install -qqy tmux autojump vim-nox

sudo apt-get install neovim
sudo pip install neovim

# For the macsters that only make things available via brew
sudo apt-get install -qqy build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
ruby -e "$(wget -O- https://raw.github.com/Homebrew/linuxbrew/go/install)"

brew install --HEAD hub

sudo apt-get install -qqy silversearcher-ag

# Stuff for vim plugins (YouCompleteMe, tern_for_vim)
sudo apt-get install cmake nodejs nodejs-legacy npm

source $(dirname $0)/common.sh
