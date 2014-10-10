#!/bin/bash

DOTFILES=$(git rev-parse --show-toplevel);

cd $DOTFILES

# Delete any existing files before stowing
#   In order to support stowing, delete top-level files
#   only if they're not directories
for file in $(ls -A unix); do
    rm ~/$file
done
# Explicitly delete ~/.vimrc if it is a directory,
# because it never has anything worth keeping
if [ -d ~/.vimrc ];
then
    rm -rf ~/.vimrc
fi

stow -v -t ~ unix

rm -rf $DOTFILES/bin/hub
hub hub standalone > $DOTFILES/unix/bin/hub && chmod +x $DOTFILES/unix/bin/hub

pip install virtualenvwrapper

echo "Installing git-submodule-move"
git clone --quiet git://github.com/iam-TJ/git-submodule-move.git $DOTFILES/unix/bin/git-submodule-move

echo "Installing git-hooks"
git clone --quiet git://github.com/icefox/git-hooks.git $DOTFILES/unix/bin/git-hooks

if [ ! -e ~/.vim/bundle/neobundle.vim ]
then
    echo "Cloning NeoBundle"
    git clone --quiet git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi
~/.vim/bundle/neobundle.vim/bin/neoinstall
