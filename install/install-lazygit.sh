#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/common.sh"

log "Installing Lazygit and linking config"

install_packages lazygit stow

backup_path "$HOME/.config/lazygit"
stow_module "lazygit"

log "Lazygit setup complete. Launch with 'lazygit' to verify."

