#!/bin/bash
source lib.sh

files=("vim" ".vim" "vim/vimrc" ".vimrc")
install "${files[@]}"

echo "Installing rm-vimview"
ln -sf $DOTFILES/vim/rm-vimview $DOTFILES/bin/rm-vimview

if [ ! -e ~/.vim/bundle/neobundle.vim ]
then
    echo "Cloning NeoBundle"
    git clone --quiet git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi
vim -u ~/.vim/bundles.vim +NeoBundleInstall +qall
vim -u ~/.vim/bundles.vim +NeoBundleUpdate +qall
