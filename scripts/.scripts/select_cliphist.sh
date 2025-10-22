#!/usr/bin/env bash

# History file
histfile="$HOME/.cache/cliphist"
placeholder="<NEWLINE>"

# Fetch the current clipboard contents into $clip
fetch_clipboard() {
  clip=$(wl-paste 2>/dev/null)
}

# Write $clip into the history file (one line, with newlines replaced)
write_history() {
  [ -f "$histfile" ] || { notify-send "Creating clipboard history at $histfile"; touch "$histfile"; }
  [ -z "$clip" ] && exit 0

  # Replace real newlines with placeholder so each entry stays on one line
  multiline=$(echo "$clip" | sed ':a;N;$!ba;s/\n/'"$placeholder"'/g')

  # Only append if it's new
  if ! grep -Fxq "$multiline" "$histfile"; then
    echo "$multiline" >> "$histfile"
    notification="Added to history."
  else
    notification="Already in history."
  fi
}

# Select an entry from history via wofi, restore newlines, copy back to clipboard
select_from_history() {
  # Show last 100 entries (tac reverses, head limits, then tac back)
  selection=$(tac "$histfile" | head -n 100 | tac \
              | wofi -d -p "Clipboard history:" -l 5)
  [ -z "$selection" ] && exit 0

  # Restore real newlines and copy to clipboard
  echo "$selection" | sed "s/$placeholder/\n/g" | wl-copy
  notification="Copied to clipboard!"
}

case "$1" in
  add)
    fetch_clipboard
    write_history
    ;;
  out)
    # Run a command and pipe its stdout into the clipboard + history
    clip=$(cat)               # read stdin into $clip
    echo "$clip" | wl-copy
    write_history
    ;;
  sel)
    select_from_history
    ;;
  *)
    cat <<EOF
Usage: $0 | File: $histfile

  add    – grab current clipboard (wl-paste), store in history
  out    – pipe stdin into clipboard (wl-copy) and history
  sel    – select an entry via wofi and recopy it

Example:
  echo "hello" | $0 out
  $0 add
  $0 sel
EOF
    exit 0
    ;;
esac

# Send notification if we set one
[ -n "$notification" ] && notify-send "$notification"

