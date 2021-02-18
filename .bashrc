export GPG_TTY=$(tty)
gpg-agent --daemon --enable-ssh-support \
          --write-env-file "${HOME}/.gpg-agent-info"
eval $(ssh-agent -s)
ssh-add $HOME/.ssh/github-personal
