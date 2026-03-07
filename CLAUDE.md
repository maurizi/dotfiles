# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). The `unix/` directory mirrors the home directory structure — `stow -t ~ unix` symlinks everything into `~`.

## Setup / Installation

**macOS:**
```bash
./scripts/macos.sh
```

**Ubuntu (CLI):**
```bash
./scripts/ubuntu.sh
```

Both scripts install dependencies for their platform, then call `scripts/common.sh` which does the actual stowing.

`scripts/common.sh` handles:
1. Removing any conflicting top-level files in `~`
2. Creating necessary nested directories
3. Running `stow -v -t ~ unix`
4. Cloning zgen and NeoBundle if not present
5. Running NeoBundle to install vim plugins

## Repository Structure

- `unix/` — dotfiles stowed to `~` on any Unix system
- `windows/` — Windows-specific configs (gitconfig, vimfiles, Vagrantfile)
- `scripts/` — platform setup scripts (`macos.sh`, `ubuntu.sh`, `ubuntu-desktop.sh`, `babun.sh`, `common.sh`)

## Key Dotfiles

- `unix/.zshrc` — zsh config; uses **zgen** to manage oh-my-zsh plugins; sets up nvm, pyenv, rustup, thefuck, autojump, dircolors; auto-starts tmux (except in VS Code terminal)
- `unix/.vimrc` — vim/neovim config; sources `$VIMHOME/bundles.vim` for all plugin declarations
- `windows/vimfiles/bundles.vim` — NeoBundle plugin list, shared between platforms; on Unix it's expected at `~/.vim/bundles.vim`
- `unix/.config/nvim/init.vim` — neovim shim that delegates to `~/.vimrc`
- `unix/.tmux.conf` — vim-aware pane switching (C-h/j/k/l), mouse on, macOS clipboard fix via `reattach-to-user-namespace`

## Conventions

- The `vim` command is aliased to a reminder to use `nvim` instead.
- `GOPATH` is set to `$HOME`.
- `~/bin` is on `$PATH` for personal utilities.
- Node local binaries (`node_modules/.bin`) are on `$PATH` automatically.
- WSL-specific env vars (DISPLAY, BROWSER, VAGRANT_WSL_ENABLE_WINDOWS_ACCESS) are set conditionally when `$WSLENV` is present.

## Adding New Dotfiles

Place the file under `unix/` in its correct relative path (e.g., `unix/.config/foo/bar.conf`), then re-run `scripts/common.sh` (or just `stow -v -t ~ unix` if deps are already installed).
