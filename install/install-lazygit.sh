#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/common.sh"

log "Installing Lazygit and linking config"

if using_apt; then
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
  TMP_DIR=$(mktemp -d)
  pushd "$TMP_DIR" >/dev/null
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit -D -t /usr/local/bin/
  popd >/dev/null
  rm -rf "$TMP_DIR"
else
  install_packages lazygit
fi

backup_path "$HOME/.config/lazygit"
stow_module "lazygit"

log "Lazygit setup complete. Launch with 'lazygit' to verify."
