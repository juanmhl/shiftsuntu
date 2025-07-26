#!/bin/bash

echo "Installing Sway WM and its core components..."

# Core Sway WM and its specific utilities
# 'sway': The Wayland compositor itself.
# 'swaylock': Sway's screen locker (replaces hyprlock).
# 'swayidle': Sway's idle manager (replaces hypridle).
# 'swaybg': Sway's background setter.
# 'swayosd': Sway's On-Screen Display for volume/brightness.
sudo apt install -y sway swaylock swayidle swaybg # swayosd

# Ensure the user's Sway config directory exists
mkdir -p ~/.config/sway/

# Copy the system's default Sway config to your user's config directory
# We use 'sudo' because /etc/sway/config is owned by root.
sudo cp /etc/sway/config ~/.config/sway/config

# Ensure the copied config file is owned by your user, so you can edit it without sudo.
sudo chown $USER:$USER ~/.config/sway/config

# XDG Desktop Portal Backends (Crucial for screen sharing, file pickers, etc.)
# 'xdg-desktop-portal-wlr': The wlroots-specific backend for XDG Desktop Portal (for Sway).
# 'xdg-desktop-portal-gtk': Provides GTK-specific support for the portal (for GTK apps).
sudo apt install -y xdg-desktop-portal-wlr xdg-desktop-portal-gtk

# Polkit Agent (for password prompts for privileged actions)
# 'polkit-gnome': A widely used Polkit agent, compatible with Sway.
sudo apt install -y lxpolkit # polkit-gnome replacement

# Status Bar
# 'waybar': A highly customizable Wayland status bar.
sudo apt install -y waybar

# Notification Daemon
# 'mako': A lightweight Wayland notification daemon.
sudo apt install -y mako-notifier

# Screenshot Tool (replaces hyprshot)
# 'grimblast': A versatile Wayland screenshot tool that combines grim and slurp,
# and also offers color picking (replaces hyprpicker).
# Needs to be built or installed from PPA/Flatpak if not in standard repos.
# Let's try to install it. If not available, we can rely on grim/slurp scripts.
echo "Installing grimblast (for screenshots and color picking)..."
if apt-cache show grimblast &>/dev/null; then
  sudo apt install -y grimblast
  echo "Installed 'grimblast' via apt."
else
  echo "grimblast not found in standard repositories. It often needs to be built from source or installed via a PPA/Flatpak."
  echo "You will still have 'grim' and 'slurp' for basic screenshotting."
fi

# Application Launcher (replaces walker-bin)
# 'wofi': A dmenu-like application launcher for Wayland.
echo "Installing application launcher 'wofi'..."
sudo apt install -y wofi

# Calculation Library (compositor-agnostic)
sudo apt install -y qalculate-gtk # Library for 'qalculate-gtk' or other calculator frontends

# Removed:
# - 'hyprland-qtutils': Not applicable for Sway.
# - 'hyprshot', 'hyprpicker', 'hyprlock', 'hypridle': Replaced by Sway equivalents or Wayland-native tools.




echo "Installing additional applications required for Waybar click actions..."

# Install network-manager-gnome for nm-connection-editor
# This provides a graphical interface for NetworkManager connections.
sudo apt install -y network-manager-gnome

# Install pavucontrol for PulseAudio/PipeWire volume control
# This provides a graphical mixer for sound devices.
sudo apt install -y pavucontrol

echo "Waybar click action dependencies installed."