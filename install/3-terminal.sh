#!/bin/bash

echo "Installing core command-line utilities and a terminal emulator..."

# Basic network and archive tools.
# 'inetutils-tools' provides many standard network utilities like ping, telnet, ftp client.
sudo apt install -y wget curl unzip inetutils-tools

# Modern command-line alternatives
# fd-find is the package name for 'fd' on Ubuntu.
# Try installing 'eza'. If it fails, you'll need to consider adding a PPA or building it,
# or accept 'lsd' as an alternative (though 'eza' is generally preferred now).
# 'eza' is available in Ubuntu's universe repository in recent versions (e.g., 22.04 LTS onwards).
sudo apt install -y fd-find fzf ripgrep zoxide bat jq wl-clipboard fastfetch btop

# Essential documentation and shell enhancements
# 'manpages-posix' provides some common man pages.
sudo apt install -y manpages-posix tldr less whois plocate bash-completion

# Terminal emulator - essential for a graphical desktop environment.
# Alacritty is a good choice for Wayland.
sudo apt install -y alacritty

# Removed 'impala' as it's not a general-purpose utility for a desktop setup
# and its specific purpose for DHH is unknown without further context.
# If you discover you need a tool named 'impala', you will have to find its
# specific installation method for Ubuntu.