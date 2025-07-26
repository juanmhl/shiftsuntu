echo -e "\nUpdating package lists and installing git..."
sudo apt update -y && sudo apt install -y git

echo -e "\nCloning ShifSuntu..."
# Remove existing directory for a clean clone
rm -rf ~/.local/share/shiftsuntu/ # <--- IMPORTANT: Change 'your_dotfiles_repo_name' to the actual name of your repo/folder!
# Clone your dotfiles repository. Replace the URL with your actual dotfiles repo URL.
git clone https://github.com/juanmhl/ShiftSuntu.git ~/.local/share/shiftsuntu >/dev/null # <--- IMPORTANT: Change this URL and folder name!

# Use custom branch if instructed (if you want this feature for your dotfiles)
if [[ -n "$SHIFTSUNTU_REF" ]]; then # <--- You might want to rename OMARCHY_REF to something like YOUR_DOTFILES_REF
  echo -e "\nUsing branch: $SHIFTSUNTU_REF"
  cd ~/.local/share/shiftsuntu/ # <--- Change this folder name!
  git fetch origin "${SHIFTSUNTU_REF}" && git checkout "${SHIFTSUNTU_REF}"
  cd -
fi

echo -e "\nInstallation starting (sourcing your main install script)..."
# This assumes you have an 'install.sh' script within your cloned dotfiles repo
source ~/.local/share/shiftsuntu/install.sh # <--- Change this folder name!