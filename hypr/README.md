# Hyprland configuration

This package targets **Hyprland v0.56+** and uses the Lua configuration API introduced in v0.55.

- Entry point: `.config/hypr/hyprland.lua`
- Modules: `.config/hypr/lua/*.lua`
- Hyprpaper remains configured separately in `.config/hypr/hyprpaper.conf`.

## Install

From the repository root, restow the package so obsolete `.conf` symlinks are removed:

```bash
stow --restow hypr
```

When switching a currently running session from `hyprland.conf` to `hyprland.lua`, use a one-time full reset:

```bash
hyprctl reload full-reset
hyprctl configerrors
```

Normal edits are loaded automatically; use `hyprctl reload` when a manual reload is needed. Changes to permission rules require restarting Hyprland.

Validate the Lua configuration offline before reloading, then inspect the live state:

```bash
Hyprland --verify-config -c ~/.config/hypr/hyprland.lua
hyprctl version
hyprctl configerrors
hyprctl monitors all
hyprctl binds
hyprctl workspacerules
hyprctl animations
```

`--verify-config` had a Lua regression in the 0.55 series and is reliable again in Hyprland 0.56+. This package targets v0.56.2.

If Hyprland is launched with `uwsm`, move the environment variables from `lua/environment.lua` to `~/.config/uwsm/env` as documented by Hyprland.
