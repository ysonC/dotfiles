#!/usr/bin/env bash

# Removing unused packages (orphans)

sudo pacman -Qdtq | sudo pacman -Rns -

