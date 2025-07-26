#!/bin/bash

echo "Installing and configuring Bluetooth..."

# Install Bluetooth management tools and services
# 'bluetooth' package provides the core Bluetooth stack (BlueZ).
# 'bluez' is the official Linux Bluetooth protocol stack.
# 'bluez-tools' provides command-line tools for Bluetooth.
# 'pulseaudio-module-bluetooth' is essential for Bluetooth audio to work with PulseAudio (or PipeWire which often uses PulseAudio compatibility).
# 'blueberry' provides a graphical front-end for managing Bluetooth devices, a quality-of-life improvement.
sudo apt install -y bluetooth bluez bluez-tools pulseaudio-module-bluetooth blueberry

# Turn on Bluetooth service by default and start it now
echo "Enabling and starting Bluetooth service..."
sudo systemctl enable --now bluetooth.service

# Note: For audio over Bluetooth, you might also need to ensure PulseAudio (or PipeWire with PulseAudio bridge)
# is properly configured and running in your user session. This script only sets up the system service.