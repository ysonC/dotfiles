    selected_dir=$(fd -t d . . | fzf +m --height 50% --preview 'tree -C {}')
    if [[ -n "$selected_dir" ]]; then
        # Change to the selected directory
        cd "$selected_dir" || return 1
    fi
