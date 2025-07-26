#!/bin/bash

echo "Installing essential desktop applications and utilities..."

sudo apt-add-repository universe -y
sudo apt update -y

# Audio/Brightness Control & Multimedia Framework
# pipewire-alsa: ALSA compatibility for PipeWire
# pipewire-jack: JACK compatibility for PipeWire
# libspa-0.2-bluetooth: Bluetooth audio support for PipeWire
# pipewire-locales: For internationalization
# pipewire-bin: Core PipeWire binaries
# The meta-package 'pipewire-audio' covers many of these.
sudo apt install -y brightnessctl playerctl pamixer pipewire-audio wireplumber libspa-0.2-bluetooth

# Input Method Editor (IME) for complex character input
# These packages provide fcitx5 with GTK3 and Qt5 support, and Wayland integration.
sudo apt install -y fcitx5 fcitx5-frontend-gtk3 fcitx5-frontend-qt5 fcitx5-module-wayland fcitx5-ui-classic

# Wayland Clipboard Persistence
# Ensures copied content persists even if the source application closes.
sudo apt install -y clipman # Note: Package name is clipman on Ubuntu

# File Management and Previews
# 'nautilus' (Files) is the standard GNOME file manager.
# 'gnome-sushi' for quick previews in Nautilus.
# 'ffmpegthumbnailer' enables video thumbnails in file managers.
sudo apt install -y nautilus gnome-sushi ffmpegthumbnailer

# Screenshot/Screencasting Tools for Wayland
# 'slurp' for selecting regions, 'grim' for taking screenshots. These are common and essential for Wayland.
sudo apt install -y slurp grim

# Media Viewers
# 'mpv' for versatile video playback.
# 'evince' for PDF and other document viewing.
# 'imv' for a fast, Wayland-native image viewer.
sudo apt install -y mpv evince imv

# Web Browser
# 'chromium-browser' is the Chromium package in Ubuntu's repositories.
sudo apt install -y chromium-browser

# Librewolf install
sudo apt update && sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt update && sudo apt install librewolf -y

# Add screen recorder based on GPU (Ubuntu equivalents)
echo "Installing a Wayland screen recorder..."
# 'pciutils' provides 'lspci' for hardware detection.
sudo apt install -y pciutils

# General Wayland screen recorders often work regardless of GPU,
# though some might have optimizations or limitations.
# 'kooha' is a user-friendly graphical Wayland recorder.
# 'wl-screenrec' and 'wf-recorder' are often built from source or available via PPAs.
# For sticking to defaults, 'kooha' is a good choice if available via apt.
# If 'kooha' is not available, 'gstreamer' based recording is possible but more complex.
# For now, let's prioritize simple installation for a quality-of-life recorder.

# Check if kooha is directly available, if not, consider a different approach or manual build.
# For a "stick to defaults" approach, we'll try kooha first.
# if apt-cache show kooha &>/dev/null; then
#   sudo apt install -y kooha
#   echo "Installed 'kooha' as a Wayland screen recorder."
# else
#   # Fallback for screen recording if kooha is not found in standard repos.
#   # obs-studio is a very powerful but heavy solution.
#   # simpler CLI tools like grim/slurp combined with gstreamer can do video:
#   # sudo apt install -y gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-libav
#   echo "Kooha not found in standard repositories. Consider installing it via Flatpak or another method."
#   echo "Alternatively, for a more feature-rich solution, 'obs-studio' is available:"
#   # If you want to force OBS-Studio:
#   # sudo apt install -y obs-studio
# fi
sudo apt install -y obs-studio

# Removed 'wiremix' (custom/niche) and 'satty' (redundant with grim/slurp for basic needs).