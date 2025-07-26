#!/bin/bash

echo "Setting up system-wide theming preferences..."

# Install Kvantum for Qt application theming
# 'kvantum' is the engine, 'qt5ct' and 'qt6ct' are the configuration tools for Qt5 and Qt6 respectively.
# After installation, you'll need to set the QT_QPA_PLATFORMTHEME environment variable.
# This can typically be done in your ~/.profile or ~/.bashrc, or through your Sway config.
sudo apt install -y kvantum qt5ct qt6ct

# Install Adwaita-dark theme for GTK applications
sudo apt install -y gnome-themes-extra

# Prefer dark mode for GTK applications and set the global color scheme preference
# These settings are read by many GTK applications.
echo "Setting GTK theme to Adwaita-dark and preferring dark color scheme..."
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# --- Centralized Theme Management Setup ---
echo "Setting up centralized theme links from your dotfiles repository..."

# Create a central directory for your themes in ~/.config/your_dotfiles_repo_name/themes
mkdir -p ~/.config/your_dotfiles_repo_name/themes # <--- Update path
# Create symlinks from your actual themes (inside your repo) to this central directory
# This assumes your themes are located in ~/.local/share/your_dotfiles_repo_name/themes/
for f in ~/.local/share/your_dotfiles_repo_name/themes/*; do # <--- Update path
  # Only symlink directories, not individual files if any might be there.
  if [ -d "$f" ]; then
    ln -s "$f" ~/.config/your_dotfiles_repo_name/themes/
  fi
done

# Set the 'current' theme and background symlinks
mkdir -p ~/.config/your_dotfiles_repo_name/current # <--- Update path
# IMPORTANT: Replace 'tokyo-night' with the name of YOUR desired default theme folder.
# This theme folder should exist under ~/.config/your_dotfiles_repo_name/themes/
echo "Setting default theme to 'tokyo-night' (or your chosen default)..."
ln -snf ~/.config/your_dotfiles_repo_name/themes/tokyo-night ~/.config/your_dotfiles_repo_name/current/theme # <--- Update path and theme name
# IMPORTANT: Update this path to YOUR default background image within YOUR chosen theme.
ln -snf ~/.config/your_dotfiles_repo_name/current/theme/backgrounds/1-scenery-pink-lakeside-sunset-lake-landscape-scenic-panorama-7680x3215-144.png ~/.config/your_dotfiles_repo_name/current/background # <--- Update path and background file

# --- Application-Specific Theme Links ---
# (Ensure your dotfiles repo contains these specific theme files within your theme folder)

# For btop
echo "Setting btop theme link..."
mkdir -p ~/.config/btop/themes
ln -snf ~/.config/your_dotfiles_repo_name/current/theme/btop.theme ~/.config/btop/themes/current.theme # <--- Update path

# For mako
echo "Setting mako config link..."
mkdir -p ~/.config/mako
ln -snf ~/.config/your_dotfiles_repo_name/current/theme/mako.ini ~/.config/mako/config # <--- Update path

# Removed the Neovim theme link as you are not using Neovim.

echo "Theming setup complete. You will need to ensure your Sway config and other apps reference the '~/.config/your_dotfiles_repo_name/current/theme/' symlink for consistent theming."