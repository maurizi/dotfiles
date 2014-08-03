#!/bin/bash

DOTFILES=$(git rev-parse --show-toplevel);

stow -v -t ~ unix

rm -rf $DOTFILES/bin/hub
hub hub standalone > $DOTFILES/unix/bin/hub && chmod +x $DOTFILES/unix/bin/hub

echo "Installing git-submodule-move"
hub clone --quiet iam-TJ/git-submodule-move $DOTFILES/unix/bin/git-submodule-move

echo "Installing git-hooks"
hub clone icefox/git-hooks $DOTFILES/unix/bin/git-hooks

echo "Setting git aliases"
git config --global alias.root '!pwd'
git config --global alias.prune-all '!git remote | xargs -n 1 git remote prune'
git config --global alias.tree 'log --graph --decorate --pretty=oneline --abbrev-commit'
git config --global alias.ls 'log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate'
git config --global alias.ll 'log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --numstat'

git config --global core.editor vim
git config --global push.default simple

if [ ! -e ~/.vim/bundle/neobundle.vim ]
then
    echo "Cloning NeoBundle"
    git clone --quiet git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi
vim +NeoBundleInstall! +qall
