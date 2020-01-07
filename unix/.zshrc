ZSH_TMUX_AUTOSTART=true

# Fix colors in tmux
export TERM="screen-256color"

# User configuration
export GOPATH=$HOME
export PATH="$HOME/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# yvm
export YVM_DIR=/home/local/AZVA-INT/mmaurizi/.yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh

# pyenv
export PATH="/home/local/AZVA-INT/mmaurizi/.pyenv/bin:$PATH"
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
    zgen load dijitalmunky/nvm-auto nvm-auto.plugin.zsh

    # Load completions
    zgen load petervanderdoes/git-flow-completion
    zgen load zsh-users/zsh-completions src
    zgen load mitchellh/packer contrib/zsh-completion

    zgen oh-my-zsh themes/nanotech

    # Save everything for fast load times
    zgen save
fi

# Show pyenv info in prompt, cribbed from
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PS1='($(pyenv version-name)) '$PS1

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
[ -f /home/mike/.travis/travis.sh ] && source /home/mike/.travis/travis.zsh
