#!/bin/bash

DOTFILES=$(git rev-parse --show-toplevel);

pact install stow

pact install tmux

echo "Installing hub"
pact install ruby
gem install -q hub >/dev/null

# For NeoComplete
pact install lua

# For fabric
pact install python python-paramiko python-crypto gcc-g++ wget openssh python-setuptools
python /usr/lib/python2.7/site-packages/easy_install.py pip
pip install ecdsa fabric

# For ansible
pip install pyyaml jinja2 ansible

# Windows configs: a little manual because we can't stow
# TODO: Migrate from stow to custom setup everywhere

# Explicitly remove and then link vimfiles
rm $USERPROFILE/vimfiles
cmd /c mklink /J $USERPROFILE\\vimfiles $(cygpath --windows $DOTFILES/windows/vimfiles)

# Use 'ag' to find appropriate files to link
# For each file, make their base directory if necessary first
cd $DOTFILES/windows
FILES=$(ag -l --hidden '.*' . 2>/dev/null)
for FILE in $FILES; do
    UNIX_FILE=$(cygpath --unix $FILE)
    TARGET_PATH=$(cygpath --unix $USERPROFILE)/$UNIX_FILE
    BASEDIR=$(dirname $TARGET_PATH)
    mkdir -p $BASEDIR
    SYMLINK=$(cygpath -w $TARGET_PATH)
    TARGET=$(cygpath -w $DOTFILES/windows/$UNIX_FILE)
    # Weirdness: cygpath is adding an unreadable char to the end of my paths....
    SYMLINK=${SYMLINK:0:${#SYMLINK}-1}
    TARGET=${TARGET:0:${#TARGET}-1}
    cmd /c mklink "$SYMLINK" "$TARGET"
done

source $DOTFILES/scripts/common.sh
