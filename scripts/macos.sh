#!/bin/bash

# Setup script for macOS

set -e
set -x

# Rosetta2
softwareupdate --install-rosetta --agree-to-license

# ── Homebrew ──────────────────────────────────────────────────────────────────
# Homebrew is the macOS package manager, equivalent to apt-get on Ubuntu.
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Apple Silicon puts brew in /opt/homebrew; add it to PATH for this session
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
fi

brew update

# ── Core CLI tools ─────────────────────────────────────────────────────────────
brew install \
    curl \
    git \
    git-gui \
    stow \
    python \
    tmux \
    zsh \
    neovim \
    gh \
    the_silver_searcher \
    cmake \
    node \
    autojump \
    go \
    openjdk@21 \
    thefuck \
    wget \
    reattach-to-user-namespace \
    coreutils   # provides gdircolors, a drop-in for Linux's dircolors


# ── Rust (rustup, same install as Linux) ──────────────────────────────────────
if ! command -v rustup &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# ── nvm (node version manager, same install as Linux) ─────────────────────────
if [ ! -d "$HOME/.nvm" ]; then
    PROFILE=/dev/null curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# ── pyenv (Python version manager, same install as Linux) ─────────────────────
if [ ! -d "$HOME/.pyenv" ]; then
    curl https://pyenv.run | bash
else
    ~/.pyenv/bin/pyenv update
fi

# ── pip packages ───────────────────────────────────────────────────────────────
$(which python3) -m pip install --break-system-packages pynvim

# ── Node global packages (matching ubuntu.sh) ──────────────────────────────────
npm install -g typescript

# ── GUI Apps (casks) ───────────────────────────────────────────────────────────
# Homebrew casks are the macOS equivalent of chocolatey GUI installs.
brew install --cask \
    google-chrome \
    firefox \
    visual-studio-code \
    keepassxc \
    iterm2 \
    vlc \
    gimp \
    inkscape \
    libreoffice \
    docker \
    openvpn-connect \
    rectangle \
    steam \
    discord \
    zoom \
    xquartz \
    adobe-acrobat-reader \
    maccy \
    utm \
    claude-code \
    android-studio \
    stats \
    kap            # macOS screen-to-gif equivalent of screentogif

# Modern equivalent to Synergy
brew tap deskflow/tap
brew install deskflow

# ── Fonts ──────────────────────────────────────────────────────────────────────
brew install --cask font-inconsolata

# ── pgAdmin 4 (pgAdmin 3 is EOL) ───────────────────────────────────────────────
brew install --cask pgadmin4

# ── AWS CLI ────────────────────────────────────────────────────────────────────
brew install awscli

# ── 7zip ───────────────────────────────────────────────────────────────────────
brew install sevenzip

# ── ffmpeg ─────────────────────────────────────────────────────────────────────
brew install ffmpeg

# ── Nextcloud client ───────────────────────────────────────────────────────────
brew install --cask nextcloud


# ── iTerm2 preferences ─────────────────────────────────────────────────────────
# Load prefs from dotfiles instead of ~/Library/Preferences
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.config/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# ── ~/bin ──────────────────────────────────────────────────────────────────────
mkdir -p ~/bin

# ── Stow dotfiles (same as common.sh) ─────────────────────────────────────────
source "$(dirname "$0")/common.sh"
