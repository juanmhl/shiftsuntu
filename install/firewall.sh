#!/bin/bash

echo "Configuring Uncomplicated Firewall (UFW) for security..."

# Install ufw and ufw-docker if not already installed
# 'ufw' is the firewall itself, 'ufw-docker' handles Docker's interaction with ufw.
# These are available in Ubuntu's standard repositories.
# sudo apt install -y ufw ufw-docker

# Set default policies: deny all incoming, allow all outgoing.
# This is a secure baseline for a workstation/server.
echo "Setting default UFW policies: deny incoming, allow outgoing..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow specific ports for LocalSend (if you plan to use it)
# If you DO NOT use LocalSend (or similar applications requiring these ports), you can remove these two lines.
echo "Allowing ports for LocalSend (53317/udp, 53317/tcp)..."
sudo ufw allow 53317/udp
sudo ufw allow 53317/tcp

# Allow SSH access (port 22/tcp). This is CRITICAL for headless server management.
echo "Allowing SSH (port 22/tcp) for remote access..."
sudo ufw allow 22/tcp

# Allow Docker containers to use host's DNS.
# This is important for containers to resolve internet hostnames.
echo "Allowing Docker containers to use host DNS on docker0 interface..."
sudo ufw allow in on docker0 to any port 53

# Enable the UFW firewall
echo "Enabling UFW firewall..."
sudo ufw enable

# Apply Docker protections for UFW. This helps prevent Docker from bypassing UFW rules.
# echo "Applying UFW-Docker protections and reloading UFW..."
# sudo ufw-docker install
sudo ufw reload

echo "UFW configured and enabled."
# Note: You might need to confirm "y" when ufw enables, depending on whether it's interactive.
# If you see a prompt, you can add '--force' to 'ufw enable' but it's not generally recommended
# for first-time enable as it removes the warning. For scripting, '--force' might be considered.
# However, for initial setup, a manual check is fine.