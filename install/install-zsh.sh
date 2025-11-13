#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/common.sh"

log "Installing Zsh and shell tooling"

install_packages zsh

ensure_directory "$HOME/.zsh"

clone_or_update_repo https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
clone_or_update_repo https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.zsh/zsh-syntax-highlighting"
clone_or_update_repo https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

backup_path "$HOME/.zshrc"
stow_module "zsh"

if command -v zsh >/dev/null 2>&1; then
  zsh_path="$(command -v zsh)"
  if [ -f /etc/shells ] && ! grep -q "$zsh_path" /etc/shells; then
    log "Adding $zsh_path to /etc/shells (sudo required)"
    echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
  fi

  if [ "${SHELL:-}" != "$zsh_path" ]; then
    log "Setting Zsh as the default shell (password prompt incoming)"
    if ! chsh -s "$zsh_path"; then
      log "Failed to change shell automatically. Run 'chsh -s $zsh_path' manually."
    fi
  fi
fi

log "Zsh setup complete."
