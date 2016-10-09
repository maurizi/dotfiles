#!/bin/bash

# Scripts for cygwin programs

set -e

DOTFILES=$(git rev-parse --show-toplevel);

pact install stow
pact install tmux
pact install vim

echo "Installing hub"
pact install ruby

# For NeoComplete
pact install lua

# For fabric
pact install python python-paramiko python-crypto gcc-g++ wget openssh python-setuptools
export PYTHONHOME=/usr
export PYTHONPATH=/usr/lib/python2.7
python /usr/lib/python2.7/site-packages/easy_install.py pip
pip install ecdsa fabric

# For ansible
pip install pyyaml jinja2 ansible

# Windows configs: a little manual because we can't stow

# Use 'ag' to find appropriate files to link
# For each file, make their base directory if necessary first
cd $DOTFILES/windows
WINDOWS_HOME=$(cygpath --unix $USERPROFILE)
FILES=$(ag -l --hidden '.*' . 2>/dev/null)
for FILE in $FILES; do
    UNIX_FILE=$(cygpath --unix $FILE)
    TARGET_PATH=$WINDOWS_HOME/$UNIX_FILE
    BASEDIR=$(dirname $TARGET_PATH)
    mkdir -p $BASEDIR
    SYMLINK=$(cygpath -w $TARGET_PATH)
    TARGET=$(cygpath -w $DOTFILES/windows/$UNIX_FILE)
    # Weirdness: cygpath is adding an unreadable char to the end of my paths....
    SYMLINK=${SYMLINK:0:${#SYMLINK}-1}
    TARGET=${TARGET:0:${#TARGET}-1}
    rm $SYMLINK || true
    cmd /c mklink "$SYMLINK" "$TARGET" || cp "$TARGET" "$SYMLINK"
done
if [ ! -e $WINDOWS_HOME/vimfiles/bundle/neobundle.vim ]
then
    echo "Cloning NeoBundle"
    mkdir $WINDOWS_HOME/vimfiles/bundle
    git clone --quiet git://github.com/Shougo/neobundle.vim.git $WINDOWS_HOME/vimfiles/bundle/neobundle.vim
fi

source $DOTFILES/scripts/common.sh
