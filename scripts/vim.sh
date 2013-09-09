#!/bin/bash
source lib.sh

files=("vim" ".vim" "vim/vimrc" ".vimrc")
install "${files[@]}"

if [ ! -e ~/.vim/bundle/vundle ]
then
    echo "Cloning vundle"
    git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi
vim -u ~/.vim/bundles.vim +BundleInstall +qall

echo "Compiling command-t"
pushd ~/.vim/bundle/Command-T/ruby/command-t
(ruby extconf.rb && make) || echo "Can't compile Command-T."
popd
