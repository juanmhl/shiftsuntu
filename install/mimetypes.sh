#!/bin/bash

echo "Configuring default applications for common file types and protocols..."

# Update the desktop file database. This is crucial after installing new apps or their .desktop files.
# It ensures your system knows about all available applications and their capabilities.
update-desktop-database ~/.local/share/applications

# Set default image viewer to imv
# We installed 'imv' in a previous step.
echo "Setting 'imv' as default image viewer..."
xdg-mime default imv.desktop image/png
xdg-mime default imv.desktop image/jpeg
xdg-mime default imv.desktop image/gif
xdg-mime default imv.desktop image/webp
xdg-mime default imv.desktop image/bmp
xdg-mime default imv.desktop image/tiff

# Set default PDF viewer to Evince (GNOME Document Viewer)
# We installed 'evince' in a previous step.
echo "Setting 'Evince' as default PDF viewer..."
xdg-mime default org.gnome.Evince.desktop application/pdf

# Set default web browser to Firefox
echo "Setting 'Firefox' as default web browser..."
xdg-settings set default-web-browser firefox.desktop
xdg-mime default firefox.desktop x-scheme-handler/http
xdg-mime default firefox.desktop x-scheme-handler/https

# Set default video player to mpv
# We installed 'mpv' in a previous step.
echo "Setting 'mpv' as default video player..."
xdg-mime default mpv.desktop video/mp4
xdg-mime default mpv.desktop video/x-msvideo
xdg-mime default mpv.desktop video/x-matroska
xdg-mime default mpv.desktop video/x-flv
xdg-mime default mpv.desktop video/x-ms-wmv
xdg-mime default mpv.desktop video/mpeg
xdg-mime default mpv.desktop video/ogg
xdg-mime default mpv.desktop video/webm
xdg-mime default mpv.desktop video/quicktime
xdg-mime default mpv.desktop video/3gpp
xdg-mime default mpv.desktop video/3gpp2
xdg-mime default mpv.desktop video/x-ms-asf
xdg-mime default mpv.desktop video/x-ogm+ogg
xdg-mime default mpv.desktop video/x-theora+ogg
xdg-mime default mpv.desktop application/ogg

echo "Default applications configured."