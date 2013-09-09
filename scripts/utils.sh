#!/bin/bash
source lib.sh

sudo apt-get install ack-grep
rm $DOTFILES/bin/ack
ln -s $(which ack-grep) $DOTFILES/bin/ack

files=( "bash_profile" ".bash_profile" "bin" "bin" )
install "${files[@]}"
