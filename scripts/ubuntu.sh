#!/bin/bash

set -e

# Neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable

sudo apt-get update

# Essentials, can't run the install scripts without em
sudo apt-get install -qqy git stow python-setuptools python-dev build-essential python-software-properties
sudo easy_install pip


# Personal tools
sudo apt-get install -qqy tmux autojump vim-nox zsh

sudo apt-get install -qqy neovim
sudo pip install --upgrade neovim

# For the macsters that only make things available via brew
if ! brew -h >/dev/null; then
    sudo apt-get install -qqy build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
    ruby -e "$(wget -O- https://raw.github.com/Homebrew/linuxbrew/go/install)"
fi

sudo apt-get install -qqy silversearcher-ag

# Stuff for vim plugins (YouCompleteMe, tern_for_vim)
sudo apt-get install -qqy cmake nodejs nodejs-legacy npm

# Need Rust for retag.rs
curl -sSf https://static.rust-lang.org/rustup.sh | sh -s -- -y

# Needs Go for scripty and hub
export GOPATH=$HOME
sudo apt-get install -qqy golang

go get github.com/github/hub
go get github.com/steventlamb/scripty

source $(dirname $0)/common.sh
