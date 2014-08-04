#!/bin/bash

DOTFILES=$(git rev-parse --show-toplevel);

# Delete any existing files before stowing
for file in $(ls -A unix); do
    rm -rf ~/$file
done


stow -v -t ~ unix

rm -rf $DOTFILES/bin/hub
hub hub standalone > $DOTFILES/unix/bin/hub && chmod +x $DOTFILES/unix/bin/hub

echo "Installing git-submodule-move"
hub clone --quiet iam-TJ/git-submodule-move $DOTFILES/unix/bin/git-submodule-move

echo "Installing git-hooks"
hub clone icefox/git-hooks $DOTFILES/unix/bin/git-hooks

if [ ! -e ~/.vim/bundle/neobundle.vim ]
then
    echo "Cloning NeoBundle"
    git clone --quiet git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi
vim +NeoBundleInstall! +qall
