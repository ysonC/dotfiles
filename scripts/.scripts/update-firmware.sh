#!/bin/bash
set -e

echo -e "\e[32mRefreshing firmware metadata...\e[0m"
fwupdmgr refresh --force >/dev/null

echo -e "\n\e[36mChecking for available firmware updates...\e[0m"
fwupdmgr get-updates | less

read -rp $'\nProceed to install these updates? [y/N]: ' confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  echo -e "\e[35mInstalling updates...\e[0m"
  sudo fwupdmgr update
  echo -e "\e[32mDone. Reboot if prompted.\e[0m"
else
  echo -e "\e[33mUpdate cancelled.\e[0m"
fi

