#!/usr/bin/env bash

echo "Dotfiles Bootstrap Script by Andrei Jiroh"
echo "Starting up in 3 seconds..."
sleep 3

echo "==> Checking for GitLab Auth tokens in env..."

if [[ $GH_PAT == "" ]] && [[ $GH_USERNAME == "" ]]; then
    echo "⚠ GH_USERNAME and GH_PAT can't be blank!"
    exit 1
# Probably change my GitLab SaaS username with yours
elif [[ $GH_USERNAME != "AndreiJirohHaliliDev2006" ]]; then
    echo "⚠ Only Andrei Jiroh can do this!"
    exit 1
elif [[ $GH_USERNAME == "AndreiJirohHaliliDev2006" ]] && [[ $GH_PAT == "" ]]; then
    echo "⚠ Missing GitLab.com PAT!"
    exit 1
else
    echo "⚠ Proceeding, please don't expect this works if things go brrr..."
fi

if [[ $PWD != $HOME ]]; then
    echo "This script only works if you're in the home directory"
    exit 1
fi

if echo $OSTYPE | grep linux-android.*; then
    # Assuming that you istalled either wget or curl
    echo "==> Installing dependencies..."
    pkg install -y man git nano gnupg openssh proot resolv-conf asciinema
    echo "info: Essientials are installed, if you need Node.js"
    echo "info: just do `pkg install nodejs` anytime"

    # Clone our stuff
    echo "==> Cloning the dotfiles repo"
    git clone https://github.com/AndreiJirohHaliliDev2006/dotfiles.git
    cd .dotfiles && git clone https://$GH_USERNAME:$GH_PAT@gitlab.com/AndreiJirohHaliliDev2006/dotfiles-secrets secrets

    if [[ $? != 0 ]]; then
       echo "❌ That kinda sus, but either only Andrei Jiroh can proceed"
       echo "   or maybe the PAT you used is invalid."
       exit 1
    else
       chmod 700 $HOME/.dotfiles/secrets
    fi

    cd ~

    # Importing our SSH keys
    echo "==> Checking if ~/.ssh exists..."
    mkdir ~/.ssh && echo "We made that directory for you." || echo "warning: ~/.ssh exists!"
    echo "==> Copying SSH keys"
    cp $HOME/.dotfiles/secrets/ssh/github-personal ~/.ssh/github-personal
    cp $HOME/.dotfiles/secrets/ssh/github-personal.pub ~/.ssh/github-personal.pub
    cp $HOME/.dotfiles/secrets/ssh/launchpad ~/.ssh/launchpad
    cp $HOME/.dotfiles/secrets/ssh/launchpad.pub ~/.ssh/launchpad.pub
    chmod 600 ~/.ssh/launchpad
    chmod 600 ~/.ssh/github-personal
    #echo "==> Generating OpenSSH client config..."
    ln -s $HOME/.ssh/config $HOME/.dotfiles/ssh/termux

    # Link softly
    echo "==> Creating soft links for .bashrc and .gitconfig"
    ln -s $HOME/.dotfiles/termux.bashrc ~/.bashrc
    ln -s $HOME/.dotfiles/termux.gitconfig ~/.gitconfig

    echo "✔ Task completed successfully."
    echo '==> Cleaning up to ensure no secrets are leaked..."
    history -c
    unset GH_USERNAME GH_PAT
    exit
#elif echo $OSTYPE | grep linux-gnu.* && ;then
else
    echo "error: Script unsupported for this machine. See the online README for"
    echo "error: guide on manual bootstrapping."
fi
