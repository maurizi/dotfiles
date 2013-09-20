#!/bin/bash
export LANG=en_US.UTF8
export PATH=~/bin:$PATH

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
   source "$HOME/.bashrc"
fi
