#!/usr/bin/bash

# Install Neovim
sudo dnf install -y neovim

# Update configs
SCRIPT=$(realpath "$0")
DIR=$(dirname "$SCRIPT")
rm -rf ~/.config/nvim
ln -s $DIR ~/.config/nvim
alias --save vi "nvim"
