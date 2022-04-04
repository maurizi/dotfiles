#!/bin/bash

# Scripts for GUI programs

set -e
set -x

# Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'

# Newer virtualbox
wget -q -O - https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" > /etc/apt/sources.list.d/virtualbox.list'

# Newer vagrant (NOTE: unofficial apt-get repo)
wget -q -O - https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# VS Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# KeepassXC, because fuck managing a billion mono libs
sudo add-apt-repository -y ppa:phoerious/keepassxc

# Nextcloud client
sudo add-apt-repository -y ppa:nextcloud-devs/client

sudo apt-get update

# Development
sudo apt-get install -qqy virtualbox virtualbox-dkms linux-headers-$(uname -r)
sudo apt-get install -qqy google-chrome-stable
sudo apt-get install -qqy code

# Docker
sudo apt-get install -qqy docker.io
sudo wget -q -O /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m`
sudo chmod +x /usr/local/bin/docker-compose
sudo groupadd docker || true
sudo usermod -aG docker $USER

# Virtualbox guest additions
wget -q -O /tmp/Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack https://download.virtualbox.org/virtualbox/6.1.32/Oracle_VM_VirtualBox_Extension_Pack-6.1.32.vbox-extpack
sudo VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
yes | sudo VBoxManage extpack install /tmp/Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack

# Utilities
sudo apt-get install -qqy gnome-tweak-tool unity-tweak-tool
sudo apt-get install -qqy vlc
sudo apt-get install -qqy pidgin pidgin-otr
sudo apt-get install -qqy redshift-gtk

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
