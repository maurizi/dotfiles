#!/bin/bash

DOTFILES=$(git rev-parse --show-toplevel);

install ()
{
    local files=( "$@" )
    local toDelete=""
    local paths=()
    local links=()

    for (( i=0; i<${#files[@]}; i+=2))
    do
        local path="$DOTFILES/${files[$i]}"
        local link=~/"${files[(($i+1))]:-${files[$i]}}"

        paths+=($path)
        links+=($link)

        if [ -e "$link" ]
        then
            echo "$link already exists."
            toDelete="$toDelete $link"
        fi
    done

    if [ -n "$toDelete" ]
    then
        echo -n "Are you sure to delete these files? (yes or no): "
        read Arg
        case $Arg in
            y|Y|yes|Yes)
                echo "deleting $toDelete"
                rm -rf $toDelete
                ;;
            n|N|no|No)
                 echo "Aborted by user"
                 exit 0;;
        esac
    fi

    for (( i=0; i<${#paths[@]}; i++))
    do
        local path="${paths[$i]}"
        local link="${links[$i]}"
        ln -s $path $link
    done
}
