#!/bin/bash

# Scripts for GUI programs

set -e

# Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'

# Newer virtualbox
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb https://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" > /etc/apt/sources.list.d/virtualbox.list'

# Newer vagrant (NOTE: unofficial apt repo)
sudo bash -c 'echo deb https://vagrant-deb.linestarve.com/ any main > /etc/apt/sources.list.d/unofficial-vagrant.list'
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key AD319E0F7CFFA38B4D9F6E55CE3F3DE92099F7A4

# KeepassXC, because fuck managing a billion mono libs
sudo add-apt-repository -y ppa:phoerious/keepassxc

# Nextcloud client
sudo add-apt-repository -y ppa:nextcloud-devs/client

sudo apt update

# Development
sudo apt install -qqy virtualbox-6.0 dkms linux-headers-$(uname -r) vagrant
sudo apt install -qqy openjdk-8-jdk
sudo apt install -qqy google-chrome-stable

# Virtualbox guest additions
wget -q -O /tmp/Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack https://download.virtualbox.org/virtualbox/6.0.4/Oracle_VM_VirtualBox_Extension_Pack-6.0.4.vbox-extpack
sudo VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
yes | sudo VBoxManage extpack install /tmp/Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack

# Utilities
sudo apt install -qqy gnome-tweak-tool unity-tweak-tool
sudo apt install -qqy vlc
sudo apt install -qqy pidgin pidgin-otr
sudo apt install -qqy redshift-gtk
sudo apt install -qqy git-gui

# Download stuff
sudo apt install -qqy openvpn
sudo apt install -qqy qbittorrent

# Keepass stuff
sudo apt install -qqy nextcloud-client
sudo apt install -qqy keepassxc

# Android Studio requirements (emulator acceleration)
sudo apt install -qqy qemu-kvm bridge-utils

# Android Studio requirements (SDK requirements)
sudo apt install -qqy lib32stdc++6 lib32z1
