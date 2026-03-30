#!/bin/bash

# Scripts for Ubuntu desktop / GUI programs (tested on 24.04 LTS)

set -e
set -x

# ── Google Chrome ─────────────────────────────────────────────────────────────
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --yes --dearmor -o /etc/apt/keyrings/google-chrome.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null

# ── VirtualBox ────────────────────────────────────────────────────────────────
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --dearmor -o /etc/apt/keyrings/virtualbox.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/virtualbox.gpg] https://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list > /dev/null

# ── VS Code ───────────────────────────────────────────────────────────────────
# Clean up old key/source files (previous installs and VS Code's own updater leave these behind)
sudo rm -f /usr/share/keyrings/microsoft.gpg /etc/apt/trusted.gpg.d/packages.microsoft.gpg
sudo rm -f /etc/apt/sources.list.d/vscode.sources /etc/apt/sources.list.d/vscode.list.save
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --yes --dearmor -o /etc/apt/keyrings/microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

# ── HashiCorp (Vagrant) ──────────────────────────────────────────────────────
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --yes --dearmor -o /etc/apt/keyrings/hashicorp.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

sudo apt-get update

# ── Desktop apps ──────────────────────────────────────────────────────────────
sudo apt-get install -qqy google-chrome-stable
sudo apt-get install -qqy code
sudo apt-get install -qqy virtualbox virtualbox-dkms linux-headers-$(uname -r)
sudo apt-get install -qqy vagrant

# ── Docker (from Ubuntu repos — includes Compose V2 plugin) ─────────────────
sudo apt-get install -qqy docker.io docker-compose-v2
sudo groupadd docker || true
sudo usermod -aG docker $USER

# ── Utilities ─────────────────────────────────────────────────────────────────
sudo apt-get install -qqy gnome-tweaks
sudo apt-get install -qqy vlc
sudo apt-get install -qqy redshift-gtk

# ── Download stuff ────────────────────────────────────────────────────────────
sudo apt-get install -qqy openvpn
sudo apt-get install -qqy qbittorrent

# ── KeePass + sync ───────────────────────────────────────────────────────────
sudo apt-get install -qqy nextcloud-desktop
sudo apt-get install -qqy keepassxc

# ── Android Studio requirements ──────────────────────────────────────────────
sudo apt-get install -qqy qemu-kvm bridge-utils
