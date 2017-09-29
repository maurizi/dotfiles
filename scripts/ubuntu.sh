#!/bin/bash

# Scripts for ubuntu command-line usage

set -e

# Neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
# Node.js
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

sudo apt-get update

# Essentials, can't run the install scripts without em
sudo apt-get install -qqy git stow python-setuptools python-dev build-essential python-software-properties python3-dev python-pip python3-pip


# Personal tools
sudo apt-get install -qqy tmux autojump vim-nox zsh

sudo apt-get install -qqy neovim
sudo pip2 install --upgrade neovim
sudo pip3 install --upgrade neovim
sudo pip3 install --upgrade thefuck

sudo apt-get install -qqy silversearcher-ag

# Stuff for vim plugins (YouCompleteMe, tern_for_vim)
sudo apt-get install -qqy cmake nodejs

# Need Rust for retag.rs
curl -sSf https://static.rust-lang.org/rustup.sh | sh -s -- -y

# go get Go
sudo apt-get install -qqy golang

# hub
pushd /tmp
curl -L# https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz > hub.tgz
tar zvxvf hub.tgz
sudo ./hub-linux-amd64-2.2.9/install
popd

# kj/scripty
curl -L# https://github.com/steventlamb/kj/releases/download/0.2.0/kj-x86_64-linux > ~/bin/kj
chmod +x ~/bin/kj

source $(dirname $0)/common.sh
