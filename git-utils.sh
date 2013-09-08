#!/bin/bash

git config --global alias.root '!pwd'
git config --global alias.prune-all '!git remote | xargs -n 1 git remote prune'
git config --global alias.tree 'log --graph --decorate --pretty=oneline --abbrev-commit'
git config --global alias.ls 'log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate'
git config --global alias.ll 'log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --numstat'

git config --global core.editor vim
