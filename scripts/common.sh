#!/bin/bash

# scripts common to all unixes

set -e

DOTFILES=$(git rev-parse --show-toplevel);

cd $DOTFILES

# Delete any existing files before stowing
#   In order to support stowing into existing directories like KDE configs,
#   delete top-level files only if they're not directories
for file in $(ls -A unix); do
    rm ~/$file || true > /dev/null
done

# Explicitly delete ~/.vimrc if it is a directory,
# because it never has anything worth keeping
if [ -d ~/.vimrc ];
then
    rm -rf ~/.vimrc
fi

# Ensure nested directories exist before we stow
cd unix
dirs=$(find . -type d -links 2);
cd ~
for dir in "$dirs"; do
   mkdir -p $dir || true
done
cd $DOTFILES

stow -v -t ~ unix

if [ ! -e ~/.zgen ]
then
    echo "Cloning zgen"
    git clone --quiet git://github.com/tarjoilija/zgen.git ~/.zgen
fi
if [ ! -e ~/.vim/bundle/neobundle.vim ]
then
    echo "Cloning NeoBundle"
    git clone --quiet git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi
~/.vim/bundle/neobundle.vim/bin/neoinstall
