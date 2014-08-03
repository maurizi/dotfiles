#!/bin/bash

sudo apt-get install stow

stow -v -t ~ unix

sudo apt-add-repository ppa:mizuno-as/silversearcher-ag
sudo apt-get update
sudo apt-get install -qqy silversearcher-ag

echo "Installing hub"
sudo apt-get install -qqy ruby
sudo gem install -qy hub >/dev/null

source $(dirname $0)/common.sh