#!/bin/bash

export PATH=~/bin:$PATH

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
   source "$HOME/.bashrc"
fi
