#!/usr/bin/env bash
set -euo pipefail

if command -v op --version &>/dev/null; then
  echo "1Password CLI already installed. Skipping."
  exit 0
fi

OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
  echo "Installing 1Password CLI on macOS..."

  VERSION=$(curl -s "https://app-updates.agilebits.com/product_history/CLI2" |
    grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)

  curl -sSfL "https://cache.agilebits.com/dist/1P/op2/pkg/v${VERSION}/op_apple_universal_v${VERSION}.zip" \
    -o /tmp/op.zip
  unzip -o /tmp/op.zip op -d /tmp/
  sudo mv /tmp/op /usr/local/bin/op
  sudo chmod +x /usr/local/bin/op
  rm /tmp/op.zip

elif [[ "$OS" == "Linux" ]]; then
  echo "Installing 1Password CLI on Linux via apt..."

  curl -sS https://downloads.1password.com/linux/keys/1password.asc |
    sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' |
    sudo tee /etc/apt/sources.list.d/1password.list

  sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
  curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol |
    sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol

  sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22/
  curl -sS https://downloads.1password.com/linux/keys/1password.asc |
    sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

  sudo apt update -y && sudo apt install -y 1password-cli

else
  echo "Unsupported OS: $OS" >&2
  exit 1
fi
