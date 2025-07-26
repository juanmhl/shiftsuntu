#!/bin/bash

# You can keep the ANSI art if you like, or remove it. It's purely cosmetic.
ansi_art=' ▄██████▄   ▄▄▄▄███▄▄▄▄    ▄████████   ▄████████ ▄████████    ▄█   █▄   ▄██  ▄ 
███   ███ ▄██▀▀▀███▀▀▀██▄  ███    ███   ███    ███ ███    ███   ███    ███   ███   ██▄
███   ███ ███   ███   ███  ███    ███   ███    ███ ███    █▀    ███    ███   ███▄▄▄███
███   ███ ███   ███   ███  ███    ███  ▄███▄▄▄▄██▀ ███          ▄███▄▄▄▄███▄▄ ▀▀▀▀▀▀███
███   ███ ███   ███   ███ ▀███████████ ▀▀███▀▀▀▀▀  ███          ▀▀███▀▀▀▀███▀  ▄██   ███
███   ███ ███   ███   ███   ███    ███ ▀███████████ ███   █▄    ███    ███   ███   ███
███   ███ ███   ███   ███   ███    ███   ███    ███ ███   ███   ███    ███   ███   ███
 ▀██████▀   ▀█   ███   █▀   ███    █▀    ███    ███ ████████▀   ███    █▀      ▀█████▀ 
                                           ███    ███                                   '

echo -e "\n$ansi_art\n"

echo -e "\nUpdating package lists and installing git..."
# Update package lists (like pacman -Sy) and install git if not present.
# -y or --yes automatically answers yes to prompts.
# -qq suppresses progress output, keeping it cleaner.
sudo apt update -y && sudo apt install -y git

echo -e "\nCloning your dotfiles repository (Omarchy equivalent)..."
# Remove existing directory for a clean clone
rm -rf ~/.local/share/your_dotfiles_repo_name/ # <--- IMPORTANT: Change 'your_dotfiles_repo_name' to the actual name of your repo/folder!
# Clone your dotfiles repository. Replace the URL with your actual dotfiles repo URL.
git clone YOUR_DOTFILES_REPOSITORY_URL_HERE ~/.local/share/your_dotfiles_repo_name >/dev/null # <--- IMPORTANT: Change this URL and folder name!

# Use custom branch if instructed (if you want this feature for your dotfiles)
if [[ -n "$YOUR_DOTFILES_REF" ]]; then # <--- You might want to rename OMARCHY_REF to something like YOUR_DOTFILES_REF
  echo -e "\nUsing branch: $YOUR_DOTFILES_REF"
  cd ~/.local/share/your_dotfiles_repo_name # <--- Change this folder name!
  git fetch origin "${YOUR_DOTFILES_REF}" && git checkout "${YOUR_DOTFILES_REF}"
  cd -
fi

echo -e "\nInstallation starting (sourcing your main install script)..."
# This assumes you have an 'install.sh' script within your cloned dotfiles repo
source ~/.local/share/your_dotfiles_repo_name/install.sh # <--- Change this folder name!