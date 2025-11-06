  local pkg
  pkg=$(paru -Slq | fzf --multi --ansi \
    --preview 'paru -Si {1} 2>/dev/null || paru -Sia {1}' \
    --preview-window=right:70%)
  [[ -n "$pkg" ]] && paru -S $pkg
