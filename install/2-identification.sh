#!/bin/bash

echo "Installing Gum for interactive prompts..."
# DHH uses gum for interactive prompts. Let's install it if you want to keep that functionality.
# If you prefer purely standard bash prompts without installing 'gum',
# comment out the line below and use 'read -p' for name/email input.
sudo apt install -y gum

# It's assumed ~/.local/share/your_dotfiles_repo_name/ansi.sh exists if DHH's structure is followed
# This script is likely for ANSI color codes. If you don't have an equivalent or don't need it, remove this.
# source ~/.local/share/your_dotfiles_repo_name/ansi.sh # Adjust path if needed

echo -e "\nEnter identification for git and autocomplete..."

# Use gum for input if it was installed successfully, otherwise fall back to 'read'.
if command -v gum &>/dev/null; then
  export YOUR_USER_NAME=$(gum input --placeholder "Enter full name" --prompt "Name> ")
  export YOUR_USER_EMAIL=$(gum input --placeholder "Enter email address" --prompt "Email> ")
else
  read -p "Enter full name for Git: " YOUR_USER_NAME
  read -p "Enter email address for Git: " YOUR_USER_EMAIL
fi

# These environment variables will be used by later scripts for Git configuration.
# For example, a later script might run:
# git config --global user.name "$YOUR_USER_NAME"
# git config --global user.email "$YOUR_USER_EMAIL"