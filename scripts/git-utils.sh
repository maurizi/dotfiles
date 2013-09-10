#!/bin/bash
source lib.sh

echo "Installing git-submodule-move"
cloneAndLink iam-TJ/git-submodule-move git-submodule-move

echo "Installing git-hooks"
cloneAndLink icefox/git-hooks git-hooks
install "git/git_hooks" ".git_hooks"

echo "Installing hub"
sudo apt-get install -qqy rubygems
sudo gem install -qy hub >/dev/null
rm -rf $DOTFILES/bin/hub
hub hub standalone > $DOTFILES/bin/hub && chmod +x $DOTFILES/bin/hub

# Autoload _git completion functions
if declare -f _git > /dev/null; then
    _git
fi
if declare -f _git_commands > /dev/null; then
_hub_commands=(
        'alias:show shell instructions for wrapping git'
        'pull-request:open a pull request on GitHub'
        'fork:fork origin repo on GitHub'
        'create:create new repo on GitHub for the current project'
        'browse:browse the project on GitHub'
        'compare:open GitHub compare view'
    )
    # Extend the '_git_commands' function with hub commands
    eval "$(declare -f _git_commands | sed -e 's/base_commands=(/base_commands=(${_hub_commands} /')"
fi

echo "Setting git aliases"
git config --global alias.root '!pwd'
git config --global alias.prune-all '!git remote | xargs -n 1 git remote prune'
git config --global alias.tree 'log --graph --decorate --pretty=oneline --abbrev-commit'
git config --global alias.ls 'log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate'
git config --global alias.ll 'log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --numstat'

git config --global core.editor vim
