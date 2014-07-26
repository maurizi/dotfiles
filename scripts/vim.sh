#!/bin/bash

if [ ! -e ~/.vim/bundle/neobundle.vim ]
then
    echo "Cloning NeoBundle"
    git clone --quiet git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi
vim +NeoBundleInstall! +qall
