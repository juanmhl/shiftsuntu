#!/bin/bash

echo "Installing essential development tools: Python, Miniconda, Lazygit, and Lazydocker..."

# Install Python 3 and venv (for virtual environments, good practice even with Anaconda)
sudo apt install -y python3 python3-pip python3-venv

# Install Miniconda (a minimal Anaconda installer for Python/data science environments)
# This is a quality-of-life improvement for managing Python environments and packages.
echo "Installing Miniconda..."
MINICONDA_INSTALLER="Miniconda3-latest-Linux-x86_64.sh"
# Download the latest Miniconda installer
wget https://repo.anaconda.com/miniconda/$MINICONDA_INSTALLER -O /tmp/$MINICONDA_INSTALLER

# Run the installer non-interactively.
# -b: batch mode (no prompts)
# -p: prefix (installation path)
# -u: update existing installation if found
bash /tmp/$MINICONDA_INSTALLER -b -p $HOME/miniconda3 -u

# Initialize conda for the current user's shell (bash).
# This adds necessary lines to your ~/.bashrc so 'conda' command is available.
# We're already sourcing ~/.bashrc in our main install.sh, so this will take effect.
source $HOME/miniconda3/bin/activate
conda init bash
# Deactivate base environment after init, so it doesn't auto-activate in new shells
conda deactivate
# Clean up the installer
rm /tmp/$MINICONDA_INSTALLER

# Install Lazygit
echo "Installing Lazygit..."
if apt-cache show lazygit &>/dev/null; then
  sudo apt install -y lazygit
  echo "Installed 'lazygit' via apt."
else
  echo "Lazygit not found in apt. Installing via recommended script."
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
  rm lazygit.tar.gz
  echo "Installed 'lazygit' manually to /usr/local/bin."
fi

# Install Lazydocker
echo "Installing Lazydocker..."
# Note: For lazydocker to be functional, Docker Engine needs to be installed.
# Docker installation is not covered in this script.
if apt-cache show lazydocker &>/dev/null; then
  sudo apt install -y lazydocker
  echo "Installed 'lazydocker' via apt."
else
  echo "Lazydocker not found in apt. Installing via recommended script."
  curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
  echo "Installed 'lazydocker' manually."
fi