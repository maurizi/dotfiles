#!/bin/bash

DOTFILES=$(git rev-parse --show-toplevel);

pacman -S tmux
pacman -S vim

# Install stow from source
pacman -S perl
pacman -S wget
cd /tmp
wget http://psg.mtu.edu/pub/gnu/stow/stow-2.2.0.tar.gz
gunzip stow-2.2.0.tar.gz
tar xf stow-2.2.0.tar
cd stow-2.2.0/
./configure
make install

# echo "Installing hub"
# pacman -S ruby
# gem install -q hub >/dev/null

# For NeoComplete
pacman -S lua

# For fabric
# pact install python python-paramiko python-crypto gcc-g++ wget openssh python-setuptools
# python /usr/lib/python2.7/site-packages/easy_install.py pip
# pip install ecdsa fabric

# For ansible
# pip install pyyaml jinja2 ansible


source $DOTFILES/scripts/common.sh
