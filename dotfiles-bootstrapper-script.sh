#!/usr/bin/env bash

echo "Dotfiles Bootstrap Script by Andrei Jiroh"
echo "Starting up in 3 seconds..."
sleep 3

echo "==> Checking for GitLab Auth tokens in env..."

if [[ $GITLAB_TOKEN == "" ]] && [[ $GITLAB_LOGIN == "" ]]; then
    echo "⚠ GitLab login and token can't be blank!"
    exit 1
# Probably change my GitLab SaaS username with yours
elif [[ $GITLAB_LOGIN != "AndreiJirohHaliliDev2006" ]]; then
    echo "⚠ Only Andrei Jiroh can do this!"
    exit 1
elif [[ $GITLAB_LOGIN == "AndreiJirohHaliliDev2006" ]] && [[ $GITLAB_TOKEN == "" ]]; then
    echo "⚠ Missing GitLab SaaS PAT! Check your Bitwarden vault for that key."
    exit 1
else
    echo "⚠ Proceeding, please don't expect this works if things go brrr..."
fi

#if [[ $PWD != $HOME ]]; then
#    echo "This script only works if you're in the home directory"
#    exit 1
#fi

if echo $OSTYPE | grep -qE linux-android.*; then
    # Assuming that you installed either wget or curl
    echo "==> Installing dependencies..."
    pkg install -y man git nano gnupg openssh proot resolv-conf asciinema openssl-tool
    echo "info: Essientials are installed, if you need Node.js"
    echo "info: just do 'pkg install nodejs' (we recommend"
    echo "info: installing the LTS one for stability) anytime"
    sleep 5

    # Clone our stuff
    echo "==> Cloning the dotfiles repo"
    git clone https://github.com/AndreiJirohHaliliDev2006/dotfiles.git $HOME/.dotfiles
    git clone https://$GITLAB_LOGIN:$GITLAB_TOKEN@gitlab.com/AndreiJirohHaliliDev2006/dotfiles-secrets $HOME/.dotfiles/secrets

    if [[ $? != 0 ]]; then
       echo "❌ That kinda sus, but either only Andrei Jiroh can proceed"
       echo "   or maybe the PAT you used is invalid."
       exit 1
    else
       chmod 600 $HOME/.dotfiles/secrets/{ssh,pgp}
    fi
    sleep 5

    # Importing our SSH keys
    echo "==> Checking if ~/.ssh exists..."
    mkdir ~/.ssh && echo "We made that directory for you." || echo "warning: ~/.ssh exists! Skipping directory creation, probably created during install..."
    echo "==> Copying SSH keys"
    cp $HOME/.dotfiles/secrets/ssh/github-personal ~/.ssh/github-personal
    cp $HOME/.dotfiles/secrets/ssh/github-personal.pub ~/.ssh/github-personal.pub
    cp $HOME/.dotfiles/secrets/ssh/launchpad ~/.ssh/launchpad
    cp $HOME/.dotfiles/secrets/ssh/launchpad.pub ~/.ssh/launchpad.pub
    chmod 600 ~/.ssh/launchpad
    chmod 600 ~/.ssh/github-personal
    echo "==> Creating soft links for OpenSSH client config..."
    ln -s $HOME/.dotfiles/ssh-client/termux ~/.ssh/config
    sleep 5

    # Link softly
    echo "==> Creating soft links for .bashrc and .gitconfig"
    ln -s $HOME/.dotfiles/termux.bashrc ~/.bashrc
    ln -s $HOME/.dotfiles/termux.gitconfig ~/.gitconfig
    sleep 5

    echo "==> Soft-linking your nanorc config..."
    ln -s $HOME/.dotfiles/nanorc/config/termux $HOME/.nanorc
    sleep 5

    echo "==> Installing ShellCheck from GitHub..."
    scversion="stable" # or "v0.4.7", or "latest"
    wget -qO- "https://github.com/koalaman/shellcheck/releases/download/${scversion?}/shellcheck-${scversion?}.linux.x86_64.tar.xz" | tar -xJv
    cp "shellcheck-${scversion}/shellcheck" $PREFIX/bin

    #echo "==> Installing Cloudflare CLI..."
    #wget -q0- https://github.com/cloudflare/cloudflare-go/releases/download/v0.16.0/flarectl_0.16.0_linux_armv6.tar.xz | tar -xJx

    echo "==> Installing python3-pip:thefuck..."
    pkg install clang -y && pip install thefuck -U

    echo "✔ Task completed successfully."
    echo "==> Cleaning up to ensure no secrets are leaked on env vars..."
    # just add chaos to these secrets to avoid leaks
    export GH_USERNAME=gildedguy
    export GH_PAT=build-guid-sus-among-computers-moment
    rm -rfv ~/{shellcheck,flarectl,LICENSE,README.txt,README.md}
    pkg uninstall clang --yes && apt autoremove --yes
    echo "info: Please also cleanup your shell history with 'history -c' to ensure your GitLab SaaS PAT is safe. Enjoy your day!"
    echo "info: Exiting..."
    sleep 2
    exit

elif echo "$OSTYPE" | grep -qE '^linux-gnu.*' && [ -f '/etc/debian_version' ]; then
    echo "==> Installing dependencies..."
    sudo apt install gnupg git nano -y
    if command -v python3 | grep -qE '^/usr/bin.*'; then
       sudo $(which python3) -m pip install asciinema
    elif command -v python3>>/dev/null && [ -f "$HOME/.pyenv/shims/python3" ]; then
       $(which python3) -m pip install asciinema
    fi

    echo "==> Cloning the dotfiles repo"
    git clone https://github.com/AndreiJirohHaliliDev2006/dotfiles.git $HOME/.dotfiles
    git clone https://$GITLAB_LOGIN:$GITLAB_TOKEN@gitlab.com/AndreiJirohHaliliDev2006/dotfiles-secrets $HOME/.dotfiles/secrets

    if [[ $? != 0 ]]; then
       echo "error: That kinda sus, but either only Andrei Jiroh can proceed or maybe the PAT you used is invalid."
       exit 1
    else
       chmod 600 $HOME/.dotfiles/secrets/{ssh,pgp}
    fi
    sleep 5

    echo "==> Creating soft links for .bashrc and .gitconfig"
    if [[ $SKIP_BASHRC_LINKING == "" ]] && [ ! -f "~/.bashrc" ]; then
        ln -s $HOME/.dotfiles/ubuntu.bashrc ~/.bashrc
    elif [[ $SKIP_CONFIG_LINKING == "" ]] && [ -f "~/.bashrc" ]; then
        mv ~/.bashrc ~/.bashrc.bak
        ln -s ~/.dotfiles/ubuntu.bashrc ~/.bashrc
    fi
    if [[ $SKIP_CONFIG_LINKING == "" ]] && [ ! -f "~/.gitconfig" ]; then
        ln -s $HOME/.dotfiles/linux.gitconfig ~/.gitconfig
    elif [[ $SKIP_CONFIG_LINKING == "" ]] && [ -f "~/.gitconfig" ]; then
        echo "warning: Existing Git configuration found, please manually merge them."
    fi
    sleep 5
else
    echo "error: Script unsupported for this machine. See the online README for guide on manual bootstrapping."
    exit 1
fi
