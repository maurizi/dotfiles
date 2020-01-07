#!/bin/bash

# Scripts for GUI programs

set -e
set -x

# Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'

# Newer virtualbox
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" > /etc/apt/sources.list.d/virtualbox.list'

# Newer vagrant (NOTE: unofficial apt-get repo)
sudo bash -c 'echo deb https://vagrant-deb.linestarve.com/ any main > /etc/apt/sources.list.d/unofficial-vagrant.list'
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key AD319E0F7CFFA38B4D9F6E55CE3F3DE92099F7A4

# Newer Docker
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository -y \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#    $(lsb_release -cs) \
#    stable"

# KeepassXC, because fuck managing a billion mono libs
sudo add-apt-repository -y ppa:phoerious/keepassxc

# Nextcloud client
sudo add-apt-repository -y ppa:nextcloud-devs/client

sudo apt-get update

# Development
sudo apt-get install -qqy virtualbox-6.0 dkms linux-headers-$(uname -r) vagrant
sudo apt-get install -qqy openjdk-8-jdk
sudo apt-get install -qqy google-chrome-stable
sudo apt-get install -qqy nfs-kernel-server

# node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | zsh
# yarn version manager
curl -s https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.js | node
# Python version manager
sudo apt-get install -qqy libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl
if [ ! -e ~/.pyenv ]
then
    curl https://pyenv.run | bash
else
    pyenv update
fi

# Docker
sudo apt-get install -qqy docker.io
sudo pip install docker-compose
sudo groupadd docker || true
sudo usermod -aG docker $USER

# Virtualbox guest additions
wget -q -O /tmp/Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack https://download.virtualbox.org/virtualbox/6.0.4/Oracle_VM_VirtualBox_Extension_Pack-6.0.4.vbox-extpack
sudo VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
yes | sudo VBoxManage extpack install /tmp/Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack

# Utilities
sudo apt-get install -qqy gnome-tweak-tool unity-tweak-tool
sudo apt-get install -qqy vlc
sudo apt-get install -qqy pidgin pidgin-otr
sudo apt-get install -qqy redshift-gtk
sudo apt-get install -qqy git-gui

# Download stuff
sudo apt-get install -qqy openvpn
sudo apt-get install -qqy qbittorrent

# Keepass stuff
sudo apt-get install -qqy nextcloud-client
sudo apt-get install -qqy keepassxc

# Android Studio requirements (emulator acceleration)
sudo apt-get install -qqy qemu-kvm bridge-utils

# Android Studio requirements (SDK requirements)
sudo apt-get install -qqy lib32stdc++6 lib32z1
