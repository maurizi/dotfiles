#!/bin/bash

# Scripts for ubuntu command-line usage

set -e
set -x

# Essentials, can't run the install scripts without em
sudo apt-get install -qqy curl git stow python-setuptools python-dev build-essential python3-dev python3-pip

# Neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable

sudo apt-get update

# Personal tools
sudo apt-get install -qqy tmux autojump zsh curl

sudo apt-get install -qqy neovim
sudo pip3 install --upgrade neovim
sudo pip3 install --upgrade thefuck

sudo apt-get install -qqy silversearcher-ag

# Stuff for vim plugins (YouCompleteMe, tern_for_vim)
sudo apt-get install -qqy cmake nodejs npm
sudo npm install -g jshint typescript

# Need Rust for retag.rs
curl -sSf https://sh.rustup.rs -sSf | sh -s -- -y

# go get Go
sudo apt-get install -qqy golang

# Dev
sudo apt-get install -qqy vagrant
sudo apt-get install -qqy openjdk-8-jdk
sudo apt-get install -qqy nfs-kernel-server

# node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | zsh
# yarn version manager
curl -s https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.js | node
# Python version manager
sudo apt-get install -qqy libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl
if [ ! -e ~/.pyenv ]
then
    curl https://pyenv.run | bash
else
    pyenv update
fi
sudo apt-get install -qqy git-gui

# hub
pushd /tmp
curl -L# https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz > hub.tgz
tar zvxvf hub.tgz
sudo ./hub-linux-amd64-2.2.9/install
popd

# Home directory for small utilities
mkdir -p ~/bin

# kj/scripty
mkdir ~/bin || true
curl -L# https://github.com/steventlamb/kj/releases/download/0.2.0/kj-x86_64-linux > ~/bin/kj
chmod +x ~/bin/kj

source $(dirname $0)/common.sh
