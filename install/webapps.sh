#!/bin/bash

echo "Creating custom web applications..."

# Source the functions file that contains the 'web2app' definition.
# IMPORTANT: Ensure ~/.local/share/your_dotfiles_repo_name/default/bash/functions.sh exists
# and contains the 'web2app' function from Step 1.
source ~/.local/share/your_dotfiles_repo_name/default/bash/functions.sh # <--- Update path

# Ensure the .desktop file directory exists
mkdir -p ~/.local/share/applications

# Create your desired web apps.
# You can customize this list to your frequently used web services.
# Replace the example URLs and icon URLs with your own.

# DHH's examples (updated to use chromium-browser)
web2app "HEY" https://app.hey.com https://www.hey.com/assets/images/general/hey.png
web2app "Basecamp" https://launchpad.37signals.com https://basecamp.com/assets/images/general/basecamp.png
web2app "WhatsApp" https://web.whatsapp.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/whatsapp.png
web2app "Google Photos" https://photos.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-photos.png
web2app "Google Contacts" https://contacts.google.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-contacts.png
web2app "Google Messages" https://messages.google.com/web/conversations https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/google-messages.png
web2app "ChatGPT" https://chatgpt.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/chatgpt.png
web2app "YouTube" https://www.youtube.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/youtube.png
web2app "GitHub" https://github.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/github-light.png
web2app "X" https://x.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/x-light.png
# Omitted "Omarchy Manual" as it's specific to DHH's project.
# Example for a different app:
# web2app "Jira" "https://yourcompany.atlassian.net/jira" "https://wac-cdn.atlassian.com/assets/img/favicons/jira.png"

echo "Web apps created. Updating desktop database..."
# This is crucial so your application launcher (wofi) can find the new .desktop files.
update-desktop-database ~/.local/share/applications

echo "Web applications setup complete."