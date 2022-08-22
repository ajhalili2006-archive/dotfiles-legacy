#!/usr/bin/env bash

source "$(dirname $0)/00-script-library.sh"

stage "Symlinking shell configuration files..."

if [[ $DOTFILES_OS_NAME == "android-termux" ]]; then
    if [ ! -f "$HOME/.bashrc" ]; then
      ln -s "$HOME/.dotfiles/termux.bashrc" ~/.bashrc
    elif [ -f "$HOME/.bashrc" ]; then
      cp "$HOME/.bashrc" "$HOME/.bashrc.bak"
      ln -s "$HOME/.dotfiles/termux.bashrc" ~/.bashrc
    fi
elif [[ $DOTFILES_OS_NAME == "debian" ]] || [[ $DOTFILES_OS_NAME == "ubuntu" ]]; then
    if [[ $SKIP_CONFIG_LINKING == "" ]] && [ ! -f "$HOME/.bashrc" ]; then
        ln -s "$HOME/.dotfiles/ubuntu.bashrc" ~/.bashrc
    elif [[ $GOOGLE_CLOUD_SHELL == "true" ]] && [[ $SKIP_CONFIG_LINKING == "" ]] && [ -f "$HOME/.bashrc" ]; then
        cp "$HOME/.bashrc" "$HOME/.bashrc.bak"
        ln -s "$HOME/.dotfiles/bashrc/googlecloudshell.bashrc" "$HOME/.bashrc"
    elif [[ $SKIP_CONFIG_LINKING == "" ]] && [ -f "$HOME/.bashrc" ]; then
        if [[ -L "$HOME/.bashrc" ]]; then
          warn "$HOME/.bashrc is currently symlinked somewhere, skipping the linking process"
        else
          warn "Existing bashrc found, renaming to ~/.bashrc.bak"
          mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
          ln -s "$HOME/.dotfiles/ubuntu.bashrc" "$HOME/.bashrc"
        fi
    fi
fi