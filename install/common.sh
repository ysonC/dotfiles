#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
APT_UPDATED=false
PACKAGE_MANAGER=""
PACKAGE_FLAVOR=""
CRITICAL_READY=false
CRITICAL_PACKAGES=(stow git curl tar wget)

log() {
  printf '[%s] %s\n' "$(basename "$0")" "$*"
}

error() {
  >&2 printf '[%s][ERROR] %s\n' "$(basename "$0")" "$*"
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

using_brew() {
  [[ "$PACKAGE_MANAGER" == "brew" ]]
}

using_pacman() {
  [[ "$PACKAGE_MANAGER" == "pacman" ]]
}

using_apt() {
  [[ "$PACKAGE_MANAGER" == "apt" ]]
}

maybe_update_apt() {
  if [[ "$APT_UPDATED" == "false" ]]; then
    sudo apt update
    APT_UPDATED=true
  fi
}

install_packages() {
  if [ $# -eq 0 ]; then
    return
  fi

  case "$PACKAGE_MANAGER" in
    pacman)
      sudo pacman -S --needed --noconfirm "$@"
      ;;
    apt)
      maybe_update_apt
      sudo apt install -y "$@"
      ;;
    brew)
      brew install "$@"
      ;;
    *)
      error "Unsupported package manager: ${PACKAGE_MANAGER:-unknown}"
      exit 1
      ;;
  esac
}

ensure_directory() {
  local path="$1"
  mkdir -p "$path"
}

backup_path() {
  local target="$1"

  if [ -e "$target" ] || [ -L "$target" ]; then
    local backup="${target}.backup.$(date +%s)"
    log "Backing up $target to $backup"
    mv "$target" "$backup"
  fi
}

stow_module() {
  local module="$1"
  log "Stowing module: $module"
  stow --dir "$REPO_ROOT" --target "$HOME" --restow "$module"
}

ensure_fd_alias() {
  if using_pacman || using_brew; then
    return
  fi

  if command_exists fd; then
    return
  fi

  if command_exists fdfind; then
    local link_path="/usr/local/bin/fd"
    if [ ! -e "$link_path" ]; then
      log "Creating fd compatibility symlink at $link_path"
      sudo ln -s "$(command -v fdfind)" "$link_path"
    fi
  fi
}

clone_or_update_repo() {
  local repo="$1"
  local destination="$2"

  if [ -d "$destination/.git" ]; then
    log "Updating $(basename "$destination")"
    git -C "$destination" pull --ff-only
  elif [ -d "$destination" ]; then
    log "Skipping clone, $destination already exists (non-git)."
  else
    log "Cloning $(basename "$destination")"
    git clone "$repo" "$destination"
  fi
}

detect_package_manager() {
  if command_exists pacman; then
    PACKAGE_MANAGER="pacman"
    PACKAGE_FLAVOR="Arch-based (pacman)"
  elif command_exists apt; then
    PACKAGE_MANAGER="apt"
    PACKAGE_FLAVOR="Debian/Ubuntu-based (apt)"
  elif command_exists brew; then
    PACKAGE_MANAGER="brew"
    PACKAGE_FLAVOR="Homebrew"
  else
    error "Supported package manager not found (need pacman, apt, or brew)."
    exit 1
  fi

  log "Detected package manager: $PACKAGE_MANAGER ($PACKAGE_FLAVOR)"
}

install_critical_packages() {
  if [[ "$CRITICAL_READY" == "true" ]]; then
    return
  fi

  if [ ${#CRITICAL_PACKAGES[@]} -gt 0 ]; then
    log "Installing critical packages: ${CRITICAL_PACKAGES[*]}"
    install_packages "${CRITICAL_PACKAGES[@]}"
  fi

  CRITICAL_READY=true
}

detect_package_manager
install_critical_packages
