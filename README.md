# My Dotfiles

This repository contains my personal configuration files (dotfiles) for a customized Linux desktop environment centered around the Hyprland Wayland compositor.

## Overview

This setup is tailored for a development workflow, with a focus on aesthetics and productivity. It provides a consistent and integrated experience across various command-line and graphical tools.

## Core Components

This collection of dotfiles includes configurations for the following core components:

-   **Window Manager: Hyprland**
    The configuration in `hypr/hyprland.conf` defines the behavior of the window manager, including keybindings, startup applications, window rules, and animations. It is set up to automatically launch Firefox, Kitty, Spotify, and TickTick on specific workspaces.

-   **Status Bar: Waybar**
    The `waybar/` directory contains the configuration and styling for the status bar. It is configured to display Hyprland workspaces (with custom icons for Spotify and TickTick), system information like CPU and memory usage, and a clock.

-   **Terminal: Kitty**
    The `kitty/kitty.conf` file contains settings for the Kitty terminal emulator, including font settings and theme information.

-   **Shell: Zsh**
    The `.zshrc` file configures the Zsh shell. It uses the "Pure" prompt and is enhanced with plugins such as `zsh-autosuggestions`, `zsh-syntax-highlighting`, `fzf` for fuzzy finding, and `atuin` for shell history.

-   **Editor: Neovim**
    The Neovim configuration is located in the `nvim/` directory, with `init.lua` as the entry point. It uses `lazy.nvim` for plugin management and is structured with custom keymaps and a modular plugin system.

-   **Terminal Multiplexer: Tmux**
    The `.tmux.conf` file configures the Tmux terminal multiplexer, defining keybindings, status bar appearance, and plugins managed by `tpm`.

-   **Application Launcher: Wofi**
    The `wofi/` directory contains styling for the Wofi application launcher.

-   **Installation Script: `install.sh`**
    This script automates the setup of the dotfiles on a new system. It backs up existing configurations, installs necessary packages for Debian/Ubuntu or macOS, and uses `stow` to create the required symlinks.

## Custom Scripts

-   **`select_kill_pid.sh`**: A utility script for interactively selecting and killing processes.

