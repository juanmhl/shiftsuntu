#!/bin/bash

echo "Installing and configuring power profiles daemon..."

# Install power-profiles-daemon. Available in Ubuntu's standard repositories.
sudo apt install -y power-profiles-daemon

# Detect if the computer runs on a battery (i.e., is a laptop)
if ls /sys/class/power_supply/BAT* &>/dev/null; then
  echo "Battery detected (laptop). Setting power profile to 'balanced'."
  # This computer runs on a battery, set to balanced mode.
  powerprofilesctl set balanced || true

  # Skipping custom battery monitor timer (omarchy-battery-monitor.timer)
  # This is a custom systemd --user service/timer from DHH's setup.
  # For battery notifications, consider:
  # - Configuring your Waybar (if you use it) with a battery module.
  # - Using a simple script with 'upower' command and 'mako' notifications.
  # This avoids introducing custom systemd units for now, sticking closer to defaults.
else
  echo "No battery detected (desktop/server). Setting power profile to 'performance'."
  # This computer runs on power outlet, set to performance mode.
  powerprofilesctl set performance || true
fi

echo "Power profiles configured."