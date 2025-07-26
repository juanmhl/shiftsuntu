#!/bin/bash

echo "Applying user and system configurations..."

# Copy over your dotfiles.
# Ensure your Sway, Waybar, Alacritty, etc. configs are in
# ~/.local/share/shiftsuntu/config/
# and that this 'config' directory contains the structure expected by ~/.config/.
cp -R ~/.local/share/shiftsuntu/config/* ~/.config/ 

# Use your default bashrc configuration.
# This assumes you have a custom bashrc at this path within your repo.
# echo "source ~/.local/share/shiftsuntu/default/bash/rc" >~/.bashrc 
# will stick to the default bashrc for now

# Ensure application directory exists for update-desktop-database
mkdir -p ~/.local/share/applications

# Set common git aliases (universal)
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global pull.rebase true
git config --global init.defaultBranch main # You might want to change 'master' to 'main' here for modern repos

# Set identification from install inputs.
# Using YOUR_USER_NAME and YOUR_USER_EMAIL from the previous script.
if [[ -n "${YOUR_USER_NAME//[[:space:]]/}" ]]; then
  git config --global user.name "$YOUR_USER_NAME"
fi

if [[ -n "${YOUR_USER_EMAIL//[[:space:]]/}" ]]; then
  git config --global user.email "$YOUR_USER_EMAIL"
fi