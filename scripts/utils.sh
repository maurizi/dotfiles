#!/bin/bash
source lib.sh

sudo apt-add-repository ppa:mizuno-as/silversearcher-ag
sudo apt-get update
sudo apt-get install -qqy silversearcher-ag

files=( "bash_profile" ".bash_profile" "bin" "bin" )
install "${files[@]}"
