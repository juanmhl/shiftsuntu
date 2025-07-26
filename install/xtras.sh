#!/bin/bash

echo "Installing essential desktop applications (Calculator, Keyring, Office Suite, Obsidian, Spotify)..."

# Install core desktop applications from Ubuntu's standard repositories
# - gnome-calculator: A basic graphical calculator.
# - gnome-keyring: Essential for securely managing passwords and keys for applications.
# - libreoffice: A complete office suite (Writer, Calc, Impress, etc.).
sudo apt install -y \
  gnome-calculator \
  gnome-keyring \
  libreoffice

# Install Obsidian via Snap. Snap is a common and easy way to get popular third-party apps on Ubuntu.
echo "Installing Obsidian via Snap..."
# Ensure snapd is installed, which is necessary for 'snap install' commands.
if ! command -v snap &>/dev/null; then
  echo "snapd not found. Installing snapd first..."
  sudo apt update -y
  sudo apt install -y snapd
  echo "snapd installed."
fi
sudo snap install obsidian --classic || echo -e "\e[31mFailed to install Obsidian. Continuing without!\e[0m"

# Install Spotify via Snap. Official Snap is the easiest and most common method on Ubuntu.
echo "Installing Spotify via Snap..."
sudo snap install spotify || echo -e "\e[31mFailed to install Spotify. Continuing without!\e[0m"

echo "Selected applications installation complete."