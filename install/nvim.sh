#!/bin/bash

echo "Installing Visual Studio Code..."

# VS Code is not in the default Ubuntu repositories.
# We'll add Microsoft's official APT repository to get the latest version.
# This is a standard and recommended installation method for VS Code on Debian/Ubuntu.

# 1. Install necessary packages for adding repositories
sudo apt update -y
sudo apt install -y curl gpg software-properties-common apt-transport-https

# 2. Add Microsoft's GPG key
echo "Adding Microsoft GPG key..."
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg > /dev/null

# 3. Add the Visual Studio Code repository to your Apt sources
echo "Adding VS Code repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

# 4. Update the package list with the new repository
echo "Updating package lists after adding VS Code repository..."
sudo apt update -y

# 5. Install VS Code
echo "Installing 'code' package..."
sudo apt install -y code

echo "Visual Studio Code installed."
echo "Note: Nano is typically pre-installed on Ubuntu Server. You can check by typing 'nano' in your terminal."