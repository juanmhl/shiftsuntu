#!/bin/bash

echo "Installing essential and preferred fonts..."

# Install general-purpose fonts from Ubuntu's repositories
# 'fonts-font-awesome' provides Font Awesome icons.
# 'fonts-noto-color-emoji' for color emoji support.
# 'fonts-noto-cjk' for Chinese, Japanese, Korean characters.
# 'fonts-noto-extra' for additional Noto fonts.
# 'fonts-noto' provides the basic Noto fonts.
sudo apt install -y fonts-font-awesome fonts-noto fonts-noto-color-emoji fonts-noto-cjk fonts-noto-extra

# Create user-specific fonts directory if it doesn't exist
mkdir -p ~/.local/share/fonts

# Install Cascadia Mono Nerd Font (Quality of Life for terminal/code)
# This font is typically downloaded directly from GitHub.
echo "Installing CaskaydiaMono Nerd Font..."
if ! fc-list | grep -qi "CaskaydiaMono Nerd Font"; then
  cd /tmp
  # Use 'latest' URL directly or fetch the release tag if needed
  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
  unzip CascadiaMono.zip -d CascadiaFont
  
  # Copy relevant font files to user's font directory
  cp CascadiaFont/CaskaydiaMonoNerdFont-Regular.ttf ~/.local/share/fonts
  cp CascadiaFont/CaskaydiaMonoNerdFont-Bold.ttf ~/.local/share/fonts
  cp CascadiaFont/CaskaydiaMonoNerdFont-Italic.ttf ~/.local/share/fonts
  cp CascadiaFont/CaskaydiaMonoNerdFont-BoldItalic.ttf ~/.local/share/fonts
  # The 'Propo' variants are proportional, Regular/Bold/Italic are generally what's needed.
  # If you specifically want the Proportional variants, keep these lines.
  cp CascadiaFont/CaskaydiaMonoNerdFontPropo-Regular.ttf ~/.local/share/fonts
  cp CascadiaFont/CaskaydiaMonoNerdFontPropo-Bold.ttf ~/.local/share/fonts
  cp CascadiaFont/CaskaydiaMonoNerdFontPropo-Italic.ttf ~/.local/share/fonts
  cp CascadiaFont/CaskaydiaMonoNerdFontPropo-BoldItalic.ttf ~/.local/share/fonts

  rm -rf CascadiaMono.zip CascadiaFont
  echo "CaskaydiaMono Nerd Font installed."
else
  echo "CaskaydiaMono Nerd Font already installed."
fi

# Install iA Writer Mono S (Optional: DHH's preferred coding font)
echo "Installing iA Writer Mono S font (DHH's preference - optional for you)..."
if ! fc-list | grep -qi "iA Writer Mono S"; then
  cd /tmp
  wget -O iafonts.zip https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
  unzip iafonts.zip -d iaFonts
  
  # Ensure the target directory for copying exists within the unzipped structure
  # The original path 'iA-Fonts-master/iA\ Writer\ Mono/Static/iAWriterMonoS-*.ttf' is correct if that's the structure.
  cp iaFonts/iA-Fonts-master/iA\ Writer\ Mono/Static/iAWriterMonoS-*.ttf ~/.local/share/fonts
  
  rm -rf iafonts.zip iaFonts
  echo "iA Writer Mono S font installed."
else
  echo "iA Writer Mono S font already installed."
fi

# Rebuild font cache to make new fonts available to applications
echo "Rebuilding font cache..."
fc-cache -fv # -f for force, -v for verbose output
cd - # Return to previous directory