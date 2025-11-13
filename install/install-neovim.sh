#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/common.sh"

log "Installing Neovim and related tooling"

if using_brew || using_pacman; then
  install_packages neovim ripgrep fd
else
  install_packages neovim ripgrep fd-find
  ensure_fd_alias
fi

backup_path "$HOME/.config/nvim"
stow_module "nvim"

log "Neovim setup complete. Launch with 'nvim --version' to verify."
