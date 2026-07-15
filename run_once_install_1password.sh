#!/bin/bash

if command -v op &>/dev/null; then
  echo "1Password CLI already installed. Skipping."
  exit 0
fi

# Add the repository GPG key
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

# Add the 1Password apt repository
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://1password.com stable main' | sudo tee /etc/apt/sources.txt.d/1password.list

# Create the debsig-verify policy directory and add the verification policy
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://1password.com | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

# Update repository lists and install 1Password CLI
sudo apt update -y && sudo apt install -y 1password-cli