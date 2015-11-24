ZSH_TMUX_AUTOSTART=true

# Fix colors in tmux
export TERM="screen-256color"

if [[ $(uname -o) == "Cygwin" ]]; then
    export PYTHONHOME=/usr
    export PYTHONPATH=/usr/lib/python2.7
fi

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
    zgen oh-my-zsh plugins/virtualenvwrapper
    zgen oh-my-zsh plugins/aws

    zgen load maurizi/retag.rs

    # Load completions
    zgen load zsh-users/zsh-completions src
    zgen load mitchellh/packer contrib/zsh-completion

    zgen oh-my-zsh themes/nanotech

    # Save everything for fast load times
    zgen save
fi

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

# User configuration

export PATH=$HOME/.linuxbrew/bin:$HOME/bin:/usr/local/bin:$PATH
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

eval `dircolors ~/.dircolors`

# For virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/projects
source virtualenvwrapper.sh
