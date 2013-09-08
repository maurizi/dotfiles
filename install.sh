#!/bin/bash
installers=("vim.sh")
for installer in "${installers[@]}"
do
    echo -n "Do you want to run $installer? "
    read Arg
    case $Arg in
        y|Y|yes|Yes)
            ./$installer
            ;;
        n|N|no|No)
             echo "Skipping $installer"
             continue;;
    esac
done
