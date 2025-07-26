#!/bin/bash

echo "Installing and configuring SDDM display manager for auto-login to Sway..."

# Install SDDM. It's available in Ubuntu's standard repositories.
sudo apt install -y sddm

# Ensure the Sway Wayland session desktop file exists.
# Sway usually installs a .desktop file here, which SDDM uses to list available sessions.
# Common paths are /usr/share/wayland-sessions/sway.desktop or /usr/share/xsessions/sway.desktop.
# We'll check for the Wayland-specific one first.
SWAY_DESKTOP_FILE="/usr/share/wayland-sessions/sway.desktop"
if [[ ! -f "$SWAY_DESKTOP_FILE" ]]; then
  SWAY_DESKTOP_FILE="/usr/share/xsessions/sway.desktop"
  if [[ ! -f "$SWAY_DESKTOP_FILE" ]]; then
    echo "Warning: Neither /usr/share/wayland-sessions/sway.desktop nor /usr/share/xsessions/sway.desktop found."
    echo "SDDM might not list Sway as an available session. Ensure Sway's desktop entry is correctly installed."
    # As a fallback, you could create a minimal sway.desktop file if it's truly missing.
    # For now, we'll assume the Sway package installs it.
  fi
fi

# Extract the session name from the .desktop file (e.g., 'sway' from 'sway.desktop')
# This assumes the desktop file name (without .desktop) is the session name.
SWAY_SESSION_NAME=$(basename "$SWAY_DESKTOP_FILE" .desktop)

# Configure SDDM for auto-login.
# We create a new configuration file in /etc/sddm.conf.d/
# This ensures it overrides defaults without modifying the main sddm.conf directly.
echo "Configuring SDDM for auto-login for user '$USER' into session '$SWAY_SESSION_NAME'..."
sudo mkdir -p /etc/sddm.conf.d/
sudo tee /etc/sddm.conf.d/autologin.conf <<EOF
[Autologin]
# Enable auto-login
Enabled=true
# User to automatically log in
User=$USER
# Session to automatically start (e.g., sway, plasma, gnome)
Session=$SWAY_SESSION_NAME.desktop

[Wayland]
# Enable Wayland support in SDDM
EnableHiDPI=true # Useful for high-DPI screens if SDDM itself needs scaling
# CompositorCommand= # You could specify a custom Wayland compositor here if needed, but 'sway.desktop' handles it.
EOF

# Enable SDDM service to start on boot
echo "Enabling SDDM service..."
sudo systemctl enable sddm

# Disable the standard getty@tty1.service to prevent conflicts with SDDM taking over tty1.
echo "Disabling getty@tty1.service to prevent conflicts..."
sudo systemctl disable getty@tty1.service

echo "SDDM installed and configured for auto-login to Sway WM for user '$USER'."
echo "A reboot is recommended for changes to take full effect."