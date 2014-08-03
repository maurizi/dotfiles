#!/bin/bash

sudo apt-get install stow

sudo apt-get install -qqy silversearcher-ag

# For tern
sudo apt-get install nodejs-legacy

echo "Installing hub"
sudo apt-get install -qqy ruby
sudo gem install -qy hub >/dev/null

source $(dirname $0)/common.sh
