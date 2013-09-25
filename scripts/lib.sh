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
        local link=~/"${files[(($i+1))]}"

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
                echo "Deleting $toDelete"
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

cloneAndLink ()
{
    local repo=$1
    local path=$2
    local alias=${3:-$2}
    local name=$(basename $repo)

    local url=""

    if [[ $repo =~ ^[[:graph:]]+/[[:graph:]]+$ ]]
    then
        url=https://github.com/$repo.git
    elif [[ $repo =~ ^[[:graph:]]+$ ]]
    then
        url=https://gitlab.internal.azavea.com/$repo.git
    else
        url=$repo
    fi

    if [ -d $DOTFILES/tmp/$name ] && git remote -v $DOTFILES/tmp/$name | grep -q $repo
    then
        git pull
    else
        rm -rf $DOTFILES/tmp/$name
        git clone --quiet $url $DOTFILES/tmp/$name
    fi

    ln -sf $DOTFILES/tmp/$name/$path $DOTFILES/bin/$alias
}
