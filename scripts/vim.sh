#!/bin/bash
source lib.sh

files=("vim" ".vim" "vim/vimrc" ".vimrc")
install "${files[@]}"

echo "Installing rm-vimview"
ln -sf $DOTFILES/vim/rm-vimview $DOTFILES/bin/rm-vimview

rm -rf ~/.vim/bundle/*
if [ ! -e ~/.vim/bundle/vundle ]
then
    echo "Cloning NeoBundle"
    git clone --quiet git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi
vim -u ~/.vim/bundles.vim +BundleInstall +qall

echo -n "Compiling command-t"
pushd ~/.vim/bundle/Command-T/ruby/command-t >/dev/null
(ruby extconf.rb >/dev/null && echo "..." && make >/dev/null && echo "Done") || echo "Can't compile Command-T"
popd >/dev/null
