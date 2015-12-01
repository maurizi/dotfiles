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


# Personal tools
sudo apt-get install -qqy tmux autojump vim-nox zsh

sudo apt-get install neovim
sudo pip install neovim

# For the macsters that only make things available via brew
if ! brew; then
    sudo apt-get install -qqy build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
    ruby -e "$(wget -O- https://raw.github.com/Homebrew/linuxbrew/go/install)"
fi

sudo apt-get install -qqy silversearcher-ag

# Stuff for vim plugins (YouCompleteMe, tern_for_vim)
sudo apt-get install cmake nodejs nodejs-legacy npm

# Need Rust for retag.rs
curl -sSf https://static.rust-lang.org/rustup.sh | sh

# Needs Go for scripty and hub
export GOPATH=$HOME
sudo apt-get install golang

go get github.com/github/hub
go get github.com/steventlamb/scripty

source $(dirname $0)/common.sh
