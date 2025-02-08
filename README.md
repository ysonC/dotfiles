# My Dotfiles

This repository contains my configuration files (dotfiles) for various tools such as Zsh and Neovim. I use Git for version control and the symlink method to deploy these dotfiles to their proper locations on my system.

## Overview

- **zshrc**: My Zsh configuration file.
- **nvim/**: My Neovim configuration directory.
- **install.sh**: A bootstrap script to set up symlinks and backup any existing configuration files.

By keeping all my dotfiles in this repository, I can easily sync and update them across all my devices.

## Prerequisites

- **Git**: Make sure Git is installed on your system.
- **Zsh**: This repository includes a Zsh configuration file.
- **Neovim**: My Neovim settings are included under `nvim/`.
- A Unix-like operating system (Linux, macOS, etc.)

## Installation

### 1. Clone the Repository

Clone this repository to your home directory:

```bash
git clone git@github.com:yourusername/dotfiles.git ~/dotfiles

