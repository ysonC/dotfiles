#!/usr/bin/env bash
# See raw events
# socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

socat -U - UNIX-CONNECT:"$SOCKET" | while read -r event; do
    case "$event" in
        activewindow\>\>*zen,*)
            fcitx5-remote -g Ari
            ;;

        activewindow\>\>*obsidian,*)
            fcitx5-remote -g Ari
            ;;

        openlayer\>\>*vicinae*,*)
            fcitx5-remote -g Default
            ;;

        activewindow\>\>*)
            fcitx5-remote -g Default
            ;;
    esac
done
