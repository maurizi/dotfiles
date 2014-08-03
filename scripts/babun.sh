#!/bin/bash

DOTFILES=$(git rev-parse --show-toplevel);

pact install stow

# TODO: How to install better grep on Windows?
# sudo apt-get install -qqy silversearcher-ag

echo "Installing hub"
pact install ruby
gem install -qy hub >/dev/null

# For NeoComplete
pact install lua

source $(dirname $0)/common.sh
