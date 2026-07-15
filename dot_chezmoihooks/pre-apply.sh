#! /bin/bash
set -euo pipefail

if ! command -v nix &>/dev/null; then
  echo "Nix not found. Installing via Determinate Nix Installer..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
fi

nix run home-manager/master -- switch