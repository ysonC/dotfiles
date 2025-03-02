#!/bin/bash
# ============================================
# Dotfiles Installer for macOS and Linux
# This script backs up your current dotfiles,
# installs required packages, sets up nvm and Node.js,
# configures Zsh with plugins (including Pure prompt),
# and creates symlinks for your dotfiles.
#
# This script detects your OS (macOS or Linux) and
# installs packages accordingly. On Linux (both ARM and AMD),
# it uses apt; on macOS it uses Homebrew.
# ============================================

# --- Step 0: Backup Existing Dotfiles ---
# Get the absolute path of the directory where this script is located.
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
echo "Using dotfiles from: $SCRIPT_DIR"

echo "Backing up existing dotfiles (if any)..."
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup
[ -d ~/.config/kitty ] && mv ~/.config/kitty ~/.config/kitty.backup

# --- Step 1: Detect OS ---
OS_TYPE=$(uname -s)
ARCH_TYPE=$(uname -m)
echo "Detected OS: $OS_TYPE, Architecture: $ARCH_TYPE"

# --- Step 2: Install Required Packages ---
if [ "$OS_TYPE" == "Darwin" ]; then
  echo "Running on macOS. Using Homebrew to install packages..."
  # Update Homebrew
  brew update
  
  # Install zsh, fd, and node
  brew install zsh fd node tmux ripgrep neofetch
elif [ "$OS_TYPE" == "Linux" ]; then
  echo "Running on Linux. Using apt to install packages..."
  sudo apt update
  # On Debian/Ubuntu-based systems, 'fd' is provided by fd-find.
  sudo apt install -y zsh fd-find nodejs npm xclip tmux ripgrep neofetch
  # On some Linux distributions the fd binary is installed as 'fdfind'
  # You may want to create a symlink to 'fd' for consistency:
  if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
    sudo ln -s "$(command -v fdfind)" /usr/local/bin/fd
  fi
else
  echo "Unsupported OS: $OS_TYPE"
  exit 1
fi

# --- Step 3: Install nvm and Node.js v18 ---
echo "Installing nvm..."
# Install nvm using the official install script
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

# Load nvm into the current shell session.
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
else
  echo "nvm installation not found! Please check the installation steps."
  exit 1
fi

echo "Installing Node.js v18..."
nvm install 18
nvm use 18

# --- Step 4: Set Zsh as Default Shell ---
echo "Setting Zsh as the default shell..."
chsh -s "$(which zsh)"

# --- Step 5: Install Zsh Plugins and Pure Prompt ---
echo "Setting up Zsh plugins and Pure prompt..."
mkdir -p "$HOME/.zsh"

# Install Zsh Autosuggestions if not already installed
if [ ! -d "$HOME/.zsh/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
fi

# Install Zsh Syntax Highlighting if not already installed
if [ ! -d "$HOME/.zsh/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.zsh/zsh-syntax-highlighting"
fi

# Install Pure prompt if not already installed
if [ ! -d "$HOME/.zsh/pure" ]; then
  git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

# --- Step 6: Install Tmux Plugin Manager ---
mkdir -p "$HOME/.tmux/plugins"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# --- Step 7: Install Kitty Terminal ---
mkdir -p "$HOME/.config/kitty"

# --- Step 8: Create Symlinks for Dotfiles ---
echo "Creating symlinks for dotfiles..."

# Create symlink for the Zsh configuration
ln -sf "$SCRIPT_DIR/zshrc" "$HOME/.zshrc"

# Create symlink for the Neovim configuration
mkdir -p "$HOME/.config"
ln -sf "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"

# Create symlink for the Tmux configuration
ln -sf "$SCRIPT_DIR/tmux.conf" "$HOME/.tmux.conf"

# Create symlink for the Kitty configuration
ln -sf "$SCRIPT_DIR/kitty" "$HOME/.config/kitty"

echo "Symlinks created for Zsh and Neovim and Tmux!"

# --- Final Message ---
echo "Installation complete! Please restart your terminal for all changes to take effect."

