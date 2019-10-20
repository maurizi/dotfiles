ZSH_TMUX_AUTOSTART=true

# Fix colors in tmux
export TERM="screen-256color"

# User configuration
export GOPATH=$HOME
export PATH="$HOME/bin:$PATH"

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
    zgen oh-my-zsh plugins/virtualenvwrapper
    zgen oh-my-zsh plugins/aws
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/docker-compose

    zgen load maurizi/retag.rs
    zgen load steventlamb/kj completions/kj.plugin.zsh
    zgen load gangleri/pipenv

    # Load completions
    zgen load petervanderdoes/git-flow-completion
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
    ps -p ${SSH_AGENT_PID} > /dev/null || {
        start_ssh_agent
    }
else
    start_ssh_agent
fi

eval `dircolors ~/.dircolors`
eval "$(thefuck --alias)"

# For virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/projects
source virtualenvwrapper.sh

# Stop using vim, use Neovim
alias vim='echo "Did you mean nvim?"'

# Project vars
export CC_PORT_8084=8085

# added by travis gem
[ -f /home/mike/.travis/travis.sh ] && source /home/mike/.travis/travis.zsh
