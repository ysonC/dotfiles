#!/bin/bash

pkg=$(paru -Slq | fzf --multi --ansi \
    --preview 'paru -Si {1} 2>/dev/null' \
    --preview-window=right:60%)

[[ -n "$pkg" ]] && paru -S $pkg
