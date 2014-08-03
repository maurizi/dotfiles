#!/bin/bash

DOTFILES=$(git rev-parse --show-toplevel);

pact install stow


# TODO: How to install better grep on Windows?
# sudo apt-get install -qqy silversearcher-ag

echo "Installing hub"
pact install ruby
gem install -qy hub >/dev/null

# TODO: install stuff for YouCompleteMe to build

source $(dirname $0)/common.sh
