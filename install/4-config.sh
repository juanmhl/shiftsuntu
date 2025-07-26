#!/bin/bash

echo "Applying user and system configurations..."

# Copy over your dotfiles.
# Ensure your Sway, Waybar, Alacritty, etc. configs are in
# ~/.local/share/your_dotfiles_repo_name/config/
# and that this 'config' directory contains the structure expected by ~/.config/.
cp -R ~/.local/share/your_dotfiles_repo_name/config/* ~/.config/ # <--- Update path

# Use your default bashrc configuration.
# This assumes you have a custom bashrc at this path within your repo.
echo "source ~/.local/share/your_dotfiles_repo_name/default/bash/rc" >~/.bashrc # <--- Update path

# Ensure application directory exists for update-desktop-database
mkdir -p ~/.local/share/applications

# --- GPG Configuration (SKIPPED as per your request) ---
# DHH configured GPG key servers for reliability.
# If you later need GPG functionality for things like verifying software packages or secure communication,
# you might need to configure it manually or add these steps back.

# --- PAM Lockout Policy (SKIPPED as per your request) ---
# DHH configured failed login lockout using pam_faillock.
# This is a security feature to prevent brute-force attacks on user accounts.
# Implementing this incorrectly can lock you out of your system.
# Consider learning about PAM and implementing this manually later if needed for security.

# Set common git aliases (universal)
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global pull.rebase true
git config --global init.defaultBranch master # You might want to change 'master' to 'main' here for modern repos

# Set identification from install inputs.
# Using YOUR_USER_NAME and YOUR_USER_EMAIL from the previous script.
if [[ -n "${YOUR_USER_NAME//[[:space:]]/}" ]]; then
  git config --global user.name "$YOUR_USER_NAME"
fi

if [[ -n "${YOUR_USER_EMAIL//[[:space:]]/}" ]]; then
  git config --global user.email "$YOUR_USER_EMAIL"
fi

# Set default XCompose that is triggered with CapsLock.
# This path needs to be updated to your repo's XCompose file.
# Also, variables need to be updated.
tee ~/.XCompose >/dev/null <<EOF
include "%H/.local/share/your_dotfiles_repo_name/default/xcompose"

# Identification
<Multi_key> <space> <n> : "$YOUR_USER_NAME"
<Multi_key> <space> <e> : "$YOUR_USER_EMAIL"
EOF