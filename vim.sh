#!/bin/bash
source lib.sh

files=("vim" ".vim" "vim/vimrc" ".vimrc")
install "${files[@]}"

echo "Cloning vundle"
git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qa

echo "Compiling command-t"
pushd ~/.vim/bundle/Command-T/ruby/command-t
(ruby extconf.rb && make) || echo "Can't compile Command-T."
popd
