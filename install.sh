#!/bin/bash
# Backup existing dotfiles if they exist
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup

# Install some stuff first
sudo apt install zsh fd-find nodejs npm xclip -y
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash 
nvm install 18 
nvm use 18

# Setup ZSH
sudo chsh -s $(which zsh)
# Install Plugin
mkdir -p "$HOME/.zsh"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
# Install Pure prompt
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
# Apply changes
source ~/.zshrc


# Create symlinks
ln -s ~/dotfiles/zshrc ~/.zshrc

mkdir -p ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim

echo "Symlinks created for Zsh and Neovim!"
