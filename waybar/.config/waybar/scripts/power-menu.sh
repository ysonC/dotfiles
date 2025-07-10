#!/bin/bash

choice=$(echo -e "Shutdown\nReboot\nLogout\nCancel" | wofi --dmenu --width 400 --height 250 --hide-scroll --prompt "Power" --style ~/.config/wofi/style.css)

case "$choice" in
  Shutdown) systemctl poweroff ;;
  Reboot) systemctl reboot ;;
  Logout) hyprctl dispatch exit ;;
esac
