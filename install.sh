#!/bin/bash
# Backup existing dotfiles if they exist
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup

# Create symlinks
ln -s ~/dotfiles/zshrc ~/.zshrc
# Install Pure prompt
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"


mkdir -p ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim

echo "Symlinks created for Zsh and Neovim!"

