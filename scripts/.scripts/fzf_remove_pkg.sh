#!/bin/bash

pkg=$(paru -Qm | fzf --multi --ansi \
    --preview 'paru -Qi {1} 2>/dev/null || echo "Not installed."' \
    --preview-window=right:60%)

[[ -n "$pkg" ]] && paru -Rns $pkg

