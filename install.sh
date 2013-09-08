#!/bin/bash
installers=("vim" "utils" "git-utils")
for installer in "${installers[@]}"
do
    echo -n "Do you want to install $installer? "
    read Arg
    case $Arg in
        y|Y|yes|Yes)
            ./"$installer".sh
            ;;
        n|N|no|No)
             echo "Skipping $installer"
             continue;;
    esac
done
