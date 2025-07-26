#!/bin/bash

echo "Configuring NVIDIA drivers for Wayland on Ubuntu..."

# --- GPU Detection ---
if [ -n "$(lspci | grep -i 'nvidia')" ]; then
  echo "NVIDIA GPU detected. Proceeding with driver installation and configuration."

  # --- Driver Installation (Ubuntu Recommended Method) ---
  # Ubuntu recommends using 'ubuntu-drivers' for auto-detection and installation,
  # or installing specific versions directly via apt from official repos/PPAs.
  # The 'nvidia-driver-535' (or latest stable) is a common choice.
  # 'nvidia-driver-5xx' meta-package for latest recommended.
  # 'dkms' package for automatic kernel module rebuilds.
  # 'mesa-utils' provides glxinfo, glxgears for testing.

  # Install common NVIDIA packages. Ubuntu usually installs the open kernel module
  # automatically for newer cards if supported, otherwise the proprietary.
  # The 'nvidia-driver-535' (or latest stable recommended) is generally good.
  # We should include libnvidia-common-535, libnvidia-gl-535, etc.
  # 'nvidia-utils-535' are the core utilities.
  # 'libvdpau-nvidia' for VDPAU acceleration.
  # 'libva-glx2', 'libva-drm2', 'libva-x11-2', 'vainfo' (for checking VA-API setup)
  # 'qt5-wayland', 'qt6-wayland' for Qt applications.
  # 'egl-wayland' might be pulled in or needs explicit installation.

  sudo apt update -y
  # Use ubuntu-drivers to auto-install recommended NVIDIA drivers and related packages.
  # This is the most "Ubuntu-default" way to get working NVIDIA drivers.
  echo "Running 'ubuntu-drivers autoinstall' to get recommended NVIDIA drivers..."
  sudo ubuntu-drivers autoinstall

  # Also install common Wayland/NVIDIA related packages if not pulled by autoinstall
  echo "Installing additional Wayland/NVIDIA compatibility packages..."
  sudo apt install -y \
    nvidia-utils-$(nvidia-smi --query-driver=driver_version --format=csv,noheader | cut -d'.' -f1) \
    libnvidia-common-$(nvidia-smi --query-driver=driver_version --format=csv,noheader | cut -d'.' -f1) \
    libnvidia-gl-$(nvidia-smi --query-driver=driver_version --format=csv,noheader | cut -d'.' -f1) \
    libnvidia-compute-$(nvidia-smi --query-driver=driver_version --format=csv,noheader | cut -d'.' -f1) \
    libnvidia-decode-$(nvidia-smi --query-driver=driver_version --format=csv,noheader | cut -d'.' -f1) \
    libnvidia-encode-$(nvidia-smi --query-driver=driver_version --format=csv,noheader | cut -d'.' -f1) \
    libnvidia-extra-$(nvidia-smi --query-driver=driver_version --format=csv,noheader | cut -d'.' -f1) \
    libnvidia-fbc-$(nvidia-smi --query-driver=driver_version --format=csv,noheader | cut -d'.' -f1) \
    libnvidia-ifr-$(nvidia-smi --query-driver=driver_version --format=csv,noheader | cut -d'.' -f1) \
    libnvidia-cfg1-$(nvidia-smi --query-driver=driver_version --format=csv,noheader | cut -d'.' -f1) \
    libvdpau-nvidia \
    libva-drm2 libva-x11-2 \
    qt5-wayland qt6-wayland \
    egl-wayland \
    mesa-utils # For glxinfo, glxgears (testing)

  # Check if libva-nvidia-driver (or similar) is installed for VA-API
  if ! dpkg -s libva-nvidia-driver &>/dev/null && ! dpkg -s nvidia-vaapi-driver &>/dev/null; then
    echo "Attempting to install VA-API driver for NVIDIA (might require PPA or manual build for some setups)..."
    # The NVIDIA VAAPI driver is often not in main repos, sometimes needs a PPA
    # or manual installation/compilation (e.g., from community repos like Arch).
    # For Ubuntu, 'nvidia-vaapi-driver' is the more recent name if available.
    # If not found, users might need to use a PPA like https://launchpad.net/~savoury1/+archive/ubuntu/graphics
    # For now, we'll try to install it directly.
    sudo apt install -y nvidia-vaapi-driver || sudo apt install -y libva-nvidia-driver
    if [ $? -ne 0 ]; then
      echo "Warning: NVIDIA VA-API driver (nvidia-vaapi-driver or libva-nvidia-driver) not found in standard repos."
      echo "Hardware video acceleration might not work. Consider adding a PPA or building it manually."
    fi
  fi

  # Configure modprobe for early KMS
  # This is a critical step for Wayland on NVIDIA.
  echo "Configuring modprobe for early Kernel Mode Setting (KMS) for NVIDIA..."
  echo "options nvidia_drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf >/dev/null

  # Configure initramfs for early loading of NVIDIA modules.
  # Ubuntu uses update-initramfs, not mkinitcpio.
  echo "Updating initramfs to include NVIDIA modules for early loading..."
  # The 'update-initramfs' command automatically includes necessary modules.
  # We just need to ensure it runs after modprobe.d change.
  sudo update-initramfs -u -k all

  # Add NVIDIA environment variables to Sway config
  # We will add these to a common Wayland environment file that Sway will source.
  # ~/.config/environment.d/ is a good place, or directly in ~/.profile / ~/.bashrc,
  # or sourced by ~/.config/sway/config
  # For consistency with DHH's approach (modifying a compositor config file),
  # we'll suggest adding this to your Sway config's startup commands.
  # This part assumes you have ~/.config/sway/config
  SWAY_CONF="$HOME/.config/sway/config"
  if [ -f "$SWAY_CONF" ]; then
    echo "Adding NVIDIA environment variables to Sway configuration ($SWAY_CONF)..."
    # These are crucial for NVIDIA on Wayland.
    cat >>"$SWAY_CONF" <<'EOF'

# NVIDIA environment variables for Wayland (recommended)
# Ensure these are set *before* other commands that might use them
# via `exec` in Sway config, or set them in your login shell's config.
# If using a login manager (like SDDM) and systemd --user,
# consider adding these to a ~/.config/environment.d/nvidia.conf file
# for systemd --user services. For a simple sway config, exec is fine.
exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
# And then export them. This is often handled by `sway` itself or an `.profile` sourcing
# or setting them directly here:
set_environment NVD_BACKEND direct
set_environment LIBVA_DRIVER_NAME nvidia
set_environment __GLX_VENDOR_LIBRARY_NAME nvidia
# Also consider:
# set_environment WLR_NO_HARDWARE_CURSORS 1 # If you have cursor issues
# set_environment __VK_LAYER_NV_optimus 1 # For Optimus laptops
# set_environment __GL_THREADED_OPTIMIZATIONS 1 # For general performance
# set_environment VK_ICD_FILENAMES /usr/share/vulkan/icd.d/nvidia_icd.json # Ensure Vulkan picks NVIDIA
EOF
  else
    echo "Warning: Sway configuration file ($SWAY_CONF) not found."
    echo "NVIDIA environment variables were not automatically added. Please add them manually to your Sway config or a shell init file."
  fi

else
  echo "NVIDIA GPU not detected. Skipping NVIDIA-specific driver installation."
fi

echo "NVIDIA setup script finished."