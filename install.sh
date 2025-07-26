#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Give people a chance to retry running the installation
catch_errors() {
  echo -e "\n\e[31mSway WM installation failed!\e[0m"
  echo "You can retry by running: bash ~/.local/share/your_dotfiles_repo_name/install.sh" # <--- Update path
  # You might want to update this support link to your own, or remove it.
  echo "Get help or report an issue: YOUR_SUPPORT_LINK_OR_INSTRUCTIONS_HERE"
}

trap catch_errors ERR

# Install everything by sourcing individual scripts
# IMPORTANT: Ensure your individual installation scripts are located in
# ~/.local/share/your_dotfiles_repo_name/install/
for f in ~/.local/share/your_dotfiles_repo_name/install/*.sh; do # <--- Update path
  echo -e "\nRunning installer: $f"
  source "$f"
done

# Ensure locate is up to date now that everything has been installed
echo -e "\nUpdating locate database..."
sudo updatedb

# Update all built-in packages on Ubuntu
echo -e "\nPerforming a full system upgrade..."
sudo apt update -y && sudo apt upgrade -y

# Gum is a useful tool, but might not be installed yet.
# If gum is not installed at this point, you'll need a different way to confirm reboot.
# Let's assume for now that if gum is desired, an earlier script in 'install/' will handle its installation.
# If gum is not installed, the 'gum confirm' command will fail.
# A simpler alternative for confirmation without 'gum':
read -p "Reboot to apply all settings? (y/N) " confirm_reboot
if [[ "$confirm_reboot" =~ ^[Yy]$ ]]; then
  echo "Rebooting now..."
  sudo reboot
else
  echo "Reboot deferred. Please reboot manually when ready for changes to take effect."
fi

# If you prefer to install gum earlier and use its functionality:
# gum confirm "Reboot to apply all settings?" && sudo reboot