# Start GPG and SSH agents
export GPG_TTY=$(tty)
gpg-agent --daemon --enable-ssh-support \
          --write-env-file "${HOME}/.gpg-agent-info"
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
  export SSH_AGENT_PID
else
  eval $(ssh-agent -s)
fi

# Run this with add-ssh-keys instead
#ssh-add $HOME/.ssh/github-personal

# Then add my scripts
export DOTFILES_STUFF_BIN="$HOME/.dotfiles/bin"
export PATH=$PATH:$DOTFILES_STUFF_BIN
