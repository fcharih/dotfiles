#! /bin/bash
nix profile install nixpkgs#hello
nix run home-manager/master -- switch
python3 ~/.local/share/chezmoi/.scripts/02_get_ssh_keys.py
