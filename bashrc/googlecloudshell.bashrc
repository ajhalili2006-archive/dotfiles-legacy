#!/usr/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
#case $- in
#    *i*) ;;
#      *) return;;
#esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

export PS1='\[\e]0;${DEVSHELL_PROJECT_ID:-Cloud Shell}\a\]'
# Prompt that looks like `codr@cloudshell:~/google $`
# or if the project is set `codr@cloudshell:~/google (cool-project) $`
export PS1+='\u@cloudshell:\[\033[1;34m\]\w$([[ -n $DEVSHELL_PROJECT_ID ]] && printf " \[\033[1;33m\](%s)" ${DEVSHELL_PROJECT_ID} )\[\033[00m\]$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Issue: https://github.com/google-github-actions/setup-gcloud/issues/128
# While we're in Cloud Shell and not in GitHub Actions, this should should fix the OpenSSL Not on
# Path errors when using gcloud CLI.
export LD_LIBRARY_PATH=/usr/local/lib

# After all of these, source my customized Google Cloud Shell bahsrc.
#if [ -f "/google/devshell/bashrc.google" ]; then
#  source "$HOME/.dotfiles/bashrc/google.bashrc"
#fi

# Instead of using Google Cloud Shell's preinstalled nvm, I manually installed it on my home directory.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Make sure we can use Node.js latest LTS and warn me if it's not installed.
# Should be called after sourcing Google Cloud Shell bashrc because Node Version Manager
# is installed in a custom directory
export LATEST_NODEJS_LTS_VERSION=v14.17.3
if [ ! -d "$NVM_DIR/versions/node/$LATEST_NODEJS_LTS_VERSION" ]; then
  echo "warning: Node.js $LATEST_NODEJS_LTS_VERSION isn't installed, please wait..."
  nvm install $LATEST_NODEJS_LTS_VERSION --latest-npm
fi

# custom aliases and functions I made
# scripts in ~/.local/bin and ~/.dotfiles/bin
export DOTFILES_HOME="$HOME/.dotfiles"
export DOTFILES_STUFF_BIN="$DOTFILES_HOME/bin"
export PATH="$DOTFILES_STUFF_BIN:$PATH"

# sorucing through the chain-source script
source "$DOTFILES_HOME/bashrc/chain-source" >/dev/null

# TODO: Do checks if the GitHub CLI is installed later
eval "$(gh completion -s bash)"

# https://packaging.ubuntu.com/html/getting-set-up.html#configure-your-shell
export DEBFULLNAME="Andrei Jiroh Halili"
## can't add this email to my Launchpad profile, probably because I'm using an free domain lol.
export DEBEMAIL="andreijiroh@madebythepins.tk"

# Summon our gpg-agent and ssh-agent
eval $(gpg-agent --daemon) >> /dev/null 2>&1
# We still need this, just in case gpg-agent is being a dick
source $DOTFILES_STUFF_BIN/source-ssh-agent
export GPG_TTY=$(tty)
eval "$(direnv hook bash)"