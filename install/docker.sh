#!/bin/bash

echo "Installing and configuring Docker..."

# 1. Install Docker Engine, Docker Compose, Docker Buildx
#    Using Docker's official installation method for Ubuntu for latest versions.
echo "Adding Docker's official GPG key and repository..."
sudo apt update -y
sudo apt install -y ca-certificates curl gnupg

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository to Apt sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y

echo "Installing docker-ce, docker-ce-cli, containerd.io, docker-buildx-plugin, docker-compose-plugin..."
# Install Docker Engine and related components
# docker-compose is now typically 'docker-compose-plugin'
# docker-buildx is now typically 'docker-buildx-plugin'
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 2. Limit Docker log size
# This is a good practice to prevent disk space issues.
echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json > /dev/null

# 3. Start Docker automatically (universal for systemd)
echo "Enabling Docker service to start on boot..."
sudo systemctl enable docker

# 4. Give current user privileged Docker access
# This is a major quality of life improvement for working with Docker without sudo.
echo "Adding current user (${USER}) to the docker group. Please log out and back in for this to take effect."
sudo usermod -aG docker ${USER}

# 5. Prevent Docker from preventing boot for network-online.target
# This is a specific optimization.
echo "Configuring Docker to not block boot for network-online.target..."
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/no-block-boot.conf <<'EOF'
[Unit]
DefaultDependencies=no
EOF

# Reload systemd daemon to apply changes to docker.service
sudo systemctl daemon-reload

# Restart Docker service to apply daemon.json and systemd overrides immediately
echo "Restarting Docker service to apply new configurations..."
sudo systemctl restart docker