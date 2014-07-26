#!/bin/bash

DOTFILES=$(git rev-parse --show-toplevel);
cd $DOTFILES/scripts

sudo apt-get install stow

stow -v -t ~/ $DOTFILES/unix/

installers=("vim" "utils" "git-utils")
if [ -n "$1" ]
then
    installers=( $1 )
fi
for installer in "${installers[@]}"
do
    echo -n "Do you want to install $installer? "
    read Arg
    case $Arg in
        y|Y|yes|Yes)
            $DOTFILES/scripts/"$installer".sh
            ;;
        n|N|no|No)
             echo "Skipping $installer"
             continue;;
    esac
done
