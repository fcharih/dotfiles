#! /usr/bin/env python3
import subprocess as sp
import pathlib
import sys

if pathlib.Path("/nix").exists():
    print("Nix is already installed... Skipping.")
    sys.exit(0)

cmd = "curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm"
sp.run(cmd, shell=True)
