#!/bin/bash

# Scripts for GUI programs

set -e

# Insync (Google drive)
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
sudo sh -c 'echo "deb http://apt.insynchq.com/ubuntu $(lsb_release -sc) non-free" > /etc/apt/sources.list.d/insync.list'

# Yubikey
sudo apt-add-repository -y ppa:yubico/stable

# Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'

sudo apt-get update

# Development
sudo apt-get install -qqy virtualbox virtualbox-dkms virtualbox-guest-additions-iso
sudo apt-get install -qqy openjdk-8-jdk
sudo apt-get install -qqy google-chrome-stable

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
sudo apt-get install -qqy insync
sudo apt-get install -qqy keepass2
sudo apt-get install -qqy yubikey-personalization-gui

# Keepass plugins
sudo apt-get install -qyy mono-complete
wget -q -O /tmp/otpkeyprov.zip http://keepass.info/extensions/v2/otpkeyprov/OtpKeyProv-2.4.zip
unzip /tmp/otpkeyprov.zip -d /tmp/
sudo cp /tmp/OtpKeyProv.plgx /usr/lib/keepass2/
sudo wget -q -O /usr/lib/keepass2/KeePassHttp.plgx https://raw.github.com/pfn/keepasshttp/master/KeePassHttp.plgx

wget -q -o /tmp/vagrant.deb https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4_x86_64.deb

# Android Studio requirements (emulator acceleration)
sudo apt-get install -qqy qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils

# Android Studio requirements (SDK requirements)
sudo apt-get install -qqy lib32stdc++6 lib32z1
