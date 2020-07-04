ZSH_TMUX_AUTOSTART=true

# Fix colors in tmux
export TERM="screen-256color"

# User configuration
export GOPATH=$HOME
export PATH="$HOME/bin:node_modules/.bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# yvm
export YVM_DIR="$HOME/.yvm"
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if [[ $(uname -o) == "Cygwin" ]]; then
    export PYTHONHOME=/usr
    export PYTHONPATH=/usr/lib/python2.7
    export GOPATH=$(cygpath -w $HOME)
fi

# zgen handles updating oh-my-zsh, so disable the builtin updater
DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true

# Source zgen
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins go here
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/npm
    zgen oh-my-zsh plugins/fabric
    zgen oh-my-zsh plugins/gradle
    zgen oh-my-zsh plugins/autojump
    zgen oh-my-zsh plugins/vagrant
    zgen oh-my-zsh plugins/tmux
    zgen oh-my-zsh plugins/aws
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/docker-compose

    zgen load maurizi/retag.rs
    zgen load steventlamb/kj completions/kj.plugin.zsh
    zgen load gangleri/pipenv
    zgen load yonchu/zsh-python-prompt zshrc.zsh

    # Load completions
    zgen load petervanderdoes/git-flow-completion
    zgen load zsh-users/zsh-completions src
    zgen load mitchellh/packer contrib/zsh-completion

    zgen oh-my-zsh themes/nanotech

    # Save everything for fast load times
    zgen save
fi

# Show pyenv & nvm info in prompt
function show_lang_versions {
    PYTHON_VERSION=""
    NODE_VERSION=""

    PYENV_VERSION="$(pyenv version-name)"
    if [[ $PYENV_VERSION == "$(basename $(pwd))" ]]; then
        PYTHON_VERSION="$(python --version | sed 's/Python //')"
    elif [[ $PYENV_VERSION != "system" ]]; then
        PYTHON_VERSION="$PYENV_VERSION"
    fi
    NVM_VERSION="$(nvm version)"
    NVM_DEFAULT_VERSION="$(nvm version default)"
    if [[ $NVM_VERSION != $NVM_DEFAULT_VERSION ]]; then
        NODE_VERSION="$NVM_VERSION"
    fi
    if [[ $NODE_VERSION != "" ]] || [[ $PYTHON_VERSION != "" ]]; then
        printf "("
        if [[ $PYTHON_VERSION != "" ]]; then
            printf "🐍 $PYTHON_VERSION"
        fi
        if [[ $NODE_VERSION != "" ]] && [[ $PYTHON_VERSION != "" ]]; then
            printf " : "
        fi
        if [[ $NODE_VERSION != "" ]]; then
            printf "⬡ $NODE_VERSION"
        fi
        echo ") "
    fi
}
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PS1='$(show_lang_versions)'$PS1

# autoload nvm
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

SSH_ENV=$HOME/.ssh/environment

function start_ssh_agent {
    ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    chmod 0600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    ssh-add
}

# Source SSH agent settings if it is already running, otherwise start
# up the agent properly.
if [ -f "${SSH_ENV}" ]; then
    . ${SSH_ENV} > /dev/null
    ps -p ${SSH_AGENT_PID} > /dev/null || {
        start_ssh_agent
    }
else
    start_ssh_agent
fi

eval `dircolors ~/.dircolors`
eval "$(thefuck --alias)"

# Stop using vim, use Neovim
alias vim='echo "Did you mean nvim?"'

# Project vars
export CC_PORT_8084=8085

# added by travis gem
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.zsh"
