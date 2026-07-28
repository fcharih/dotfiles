#!/usr/bin/env bash
set -euo pipefail

if command -v nix &>/dev/null; then
  echo "Nix is already installed, skipping."
  exit 0
fi

echo "Installing Nix with the Determinate installer..."
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
