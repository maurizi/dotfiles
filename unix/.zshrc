# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="nanotech"

SSH_ENV=$HOME/.ssh/environment

function start_ssh_agent {
    ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    chmod 0600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    ssh-add
}

# Source SSH agent settings if it is already running, otherwise start
# up the agent proprely.
if [ -f "${SSH_ENV}" ]; then
    . ${SSH_ENV} > /dev/null
    # ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_ssh_agent
    }
else
    start_ssh_agent
fi

# Fix colors in tmux
export TERM="screen-256color"

ZSH_TMUX_AUTOSTART=true

if [[ $(uname -o) == "Cygwin" ]]; then
    export PYTHONHOME=/usr
    export PYTHONPATH=/usr/lib/python2.7
fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git npm fabric gradle autojump git-extras vagrant tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/.linuxbrew/bin:$HOME/bin:/usr/local/bin:$PATH
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

eval `dircolors ~/.dircolors`

# For virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/projects
source virtualenvwrapper.sh
