#!/bin/bash

DOTFILES=$(git rev-parse --show-toplevel);

pact install stow

pact install tmux

echo "Installing hub"
pact install ruby
gem install -qy hub >/dev/null

# For NeoComplete
pact install lua

# For fabric
pact install python python-paramiko python-crypto gcc-g++ wget openssh python-setuptools
python /usr/lib/python2.7/site-packages/easy_install.py pip
pip install ecdsa fabric

# For ansible
pip install pyyaml jinja2 ansible

source $(dirname $0)/common.sh
