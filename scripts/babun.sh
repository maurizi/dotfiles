#!/bin/bash

DOTFILES=$(git rev-parse --show-toplevel);

pact install stow

pact install tmux

echo "Installing hub"
pact install ruby
gem install -qy hub >/dev/null

# For NeoComplete
pact install lua

source $(dirname $0)/common.sh
