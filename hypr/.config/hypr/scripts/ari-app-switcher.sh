#!/usr/bin/env bash

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

socat -U - UNIX-CONNECT:"$SOCKET" | while read -r event; do
    case "$event" in
        activewindow\>\>*zen,*)
            fcitx5-remote -g Ari
            ;;

        activewindow\>\>*obsidian,*)
            fcitx5-remote -g Ari
            ;;

        activewindow\>\>*)
            fcitx5-remote -g Default
            ;;
    esac
done
