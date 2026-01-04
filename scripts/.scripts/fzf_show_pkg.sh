#!/usr/bin/env bash

pacman -Qq | fzf --preview 'pacman -Qil {}' --bind 'enter:execute(pacman -Qil {} | less)'
