#!/bin/bash

echo "Installing and configuring CUPS (Common Unix Printing System) for printing..."

# Install CUPS and related packages. These package names are generally the same on Ubuntu.
sudo apt install -y cups cups-pdf cups-filters system-config-printer

# Enable and start the CUPS service to run automatically on boot and immediately.
sudo systemctl enable --now cups.service

echo "CUPS printing system installed and enabled."
echo "You can manage printers via 'system-config-printer' from your graphical environment,"
echo "or via the CUPS web interface at http://localhost:631 once your desktop is running."