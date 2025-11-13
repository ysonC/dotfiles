#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

modules=(
  "zsh"
  "neovim"
  "lazygit"
  "tmux"
  "eza"
)

for module in "${modules[@]}"; do
  echo "=== Installing ${module} ==="
  bash "$SCRIPT_DIR/install-${module}.sh"
  echo
done

echo "All requested CLI components have been installed."

