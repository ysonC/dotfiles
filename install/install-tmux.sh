#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/common.sh"

log "Installing Tmux and TPM"

install_packages tmux git stow

backup_path "$HOME/.tmux.conf"
stow_module "tmux"

ensure_directory "$HOME/.tmux/plugins"
clone_or_update_repo https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

log "Tmux setup complete. Start tmux and hit Prefix + I to install plugins."

