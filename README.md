# My Dotfiles

This repository contains my configuration files (dotfiles) for various tools such as Zsh (with [Pure prompt](https://github.com/sindresorhus/pure)) and Neovim. I use Git for version control and the symlink method to deploy these dotfiles to their proper locations on my system.

## Overview

- **zshrc**: My Zsh configuration file that sets up my shell environment and loads Pure prompt.
- **pure/**: The Pure prompt files (or a symlink/installation of Pure prompt) used by my Zsh configuration.
- **nvim/**: My Neovim configuration directory.
- **install.sh**: A cross-platform (macOS and Linux) bootstrap script that:
  - Backs up your existing dotfiles
  - Installs required packages
  - Configures Zsh with plugins (including Pure prompt)
  - Configures Neovim config
  - **Creates symlinks using relative paths** (i.e. it uses the directory where the script resides as the source)

## Prerequisites

- **Git**: Ensure Git is installed on your system.
- **Zsh**: This repository includes my Zsh configuration along with Pure prompt.
- **Neovim**: My Neovim settings are included under the `nvim/` directory.
- A Unix-like operating system (macOS, Linux, etc.)
- [Homebrew](https://brew.sh/) (for macOS) or `apt` (for Debian/Ubuntu Linux) for package installation

## Installation

### 1. Clone the Repository

Clone this repository to your home directory (or any preferred location):

```bash
git clone git@github.com:yourusername/dotfiles.git ~/dotfiles
```

### 2. Run the script

```bash
chmod +x install.sh
./install.sh
```
