#!/bin/bash

# Scripts for Ubuntu command-line usage (tested on 24.04 LTS)

set -e
set -x

# ── Essentials ────────────────────────────────────────────────────────────────
sudo apt-get update
sudo apt-get install -qqy curl git stow build-essential python3-dev python3-pip python3-venv pipx

# ── Neovim PPA ────────────────────────────────────────────────────────────────
sudo add-apt-repository -y ppa:neovim-ppa/unstable

# ── GitHub CLI ────────────────────────────────────────────────────────────────
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt-get update

# ── CLI tools ─────────────────────────────────────────────────────────────────
sudo apt-get install -qqy \
    tmux \
    autojump \
    zsh \
    curl \
    wget \
    neovim \
    gh \
    silversearcher-ag \
    git-gui

# ── pip packages (via pipx for CLI tools, pip for neovim bindings) ────────────
pipx install thefuck
python3 -m pip install --user --break-system-packages pynvim

# ── Stuff for vim plugins (YouCompleteMe, etc.) ──────────────────────────────
sudo apt-get install -qqy cmake nodejs npm
sudo npm install -g typescript

# ── Rust ──────────────────────────────────────────────────────────────────────
if ! command -v rustup &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# ── Go ────────────────────────────────────────────────────────────────────────
sudo apt-get install -qqy golang

# ── Java ──────────────────────────────────────────────────────────────────────
sudo apt-get install -qqy openjdk-21-jdk

# ── nvm (node version manager) ───────────────────────────────────────────────
if [ ! -d "$HOME/.nvm" ]; then
    PROFILE=/dev/null curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

# ── pyenv (Python version manager) ───────────────────────────────────────────
sudo apt-get install -qqy libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev
if [ ! -e ~/.pyenv ]; then
    curl https://pyenv.run | bash
else
    ~/.pyenv/bin/pyenv update
fi

# ── Claude Code ───────────────────────────────────────────────────────────────
curl -fsSL https://claude.ai/install.sh | bash

# ── ~/bin ─────────────────────────────────────────────────────────────────────
mkdir -p ~/bin

source "$(dirname "$0")/common.sh"
