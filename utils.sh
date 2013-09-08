#!/bin/bash
source lib.sh

sudo apt-get install ack-grep

files=( "bash_profile" ".bash_profile" "bin" "bin" )
install "${files[@]}"
