#!/bin/bash
source lib.sh

sudo apt-get install ack-grep
ln -s ack-grep $DOTFILES/bin/ack

files=( "bash_profile" ".bash_profile" "bin" "bin" )
install "${files[@]}"
