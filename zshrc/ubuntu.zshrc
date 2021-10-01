#!/usr/bin/zsh
# shellcheck disable=SC1090,SC1091,SC2088,SC2155,SC2046

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

### Oh My ZSH configuration starts below ###

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="cloud"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git command-not-found git-flow git-prompt nvm)

source $ZSH/oh-my-zsh.sh

### Oh My ZSH configuration ends here ###

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# for WSL stuff only, see https://github.com/microsoft/WSL/issues/4029
# and https://unix.stackexchange.com/questions/257061/gentoo-linux-gpg-encrypts-properly-a-file-passed-through-parameter-but-throws-i/257065#257065
export GPG_TTY=$(tty)

### Bashrc ports goes below this line! ###

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Deta CLI
[ -d "$HOME/.deta" ] && export PATH="$HOME/.deta/bin:$PATH"

# scripts in ~/.local/bin and ~/.dotfiles/bin
# also $HOME/.cargo/bin
export DOTFILES_HOME="$HOME/.dotfiles"
export DOTFILES_STUFF_BIN="$DOTFILES_HOME/bin" GOLANG_PATH=/usr/local/go/bin
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$GOLANG_PATH:$DOTFILES_STUFF_BIN:$PATH"

# use nano instead of vi by default when on SSH
# for git, there's the option of firing up VS Code, if you prefered.
#export VISUAL="code --wait"
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
	export EDITOR=nano
else
	# We'll do some checks here btw, Currently I use GNOME and Xfce4 as my desktop environments, but
	# I also consider adding KDE here in the future.
	case $(ps -o comm= -p $PPID) in
	sshd | */sshd) export EDITOR="code --wait" ;;
	xfce*) export EDITOR="$(which code >>/dev/null && echo code --wait || which gedit >>/dev/null && echo gedit || echo nano)" ;;
	gnome*) export EDITOR="$(which code >>/dev/null && echo code --wait || which gedit >>/dev/null && echo gedit || echo nano)" ;;
	code) export EDITOR="code --wait";;
	*) export EDITOR="nano" ;;
	esac
fi

# As long as possible, attempt to setup our GnuPG agent when we're on an SSH session.
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
	eval $(keychain --agents gpg,ssh --eval --nogui --noinherit)
	export GPG_TTY=$(tty)
else
	# We'll do some checks here btw, Currently I use GNOME and Xfce4 as my desktop environments
	case $(ps -o comm= -p $PPID) in
        	# Sometimes, $SSH_CLIENT and/or $SSH_TTY doesn't exists so we'll pull what ps says
		sshd | */sshd) eval $(keychain --agents gpg,ssh --eval --nogui --noinherit);;
		xfce*) eval $(keychain --agents gpg,ssh --eval);;
		gnome*) eval $(keychain --agents gpg,ssh --eval);;
		# Don't forget VS Code and code-server!
		code* | node*) eval $(keychain --agents gpg,ssh --eval);;
		*) eval $(keychain --agents gpg,ssh --eval --nogui --noinherit) ;;
	esac
fi

# autocompletion for GitHub CLI
eval "$(gh completion -s zsh)"

# custom aliases and functions I made
# sorucing through the chain-source script
source "$HOME/.dotfiles/bashrc/chain-source"

# https://packaging.ubuntu.com/html/getting-set-up.html#configure-your-shell
export DEBFULLNAME="Andrei Jiroh Halili"
# Temporary Gmail address for devel stuff, even through my longer email one is, well,
# on my public GPG key btw, so YOLO it.
export DEBEMAIL="ajhalili2006@gmail.com"

# Homebrew
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Golang, probably we need to tweak this btw
export GOPATH="$HOME/gopath"
export PATh="$GOPATH:$PATH"

# Use native builds when doing 'docker build' instead of 'docker buildx build'
export DOCKER_BUILDKIT=1

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# direnv
[ "$(which direnv)" != "" ] && eval "$(direnv hook bash)"