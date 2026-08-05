#! /usr/bin/env python3
import subprocess as sp
import pathlib
import yaml
import re
import sys

HOME = pathlib.Path.home()
platform = "macos" if sys.platform == "darwin" else "ubuntu"

packages = yaml.safe_load(open(f"{HOME}/.local/share/chezmoi/packages.yaml"))

# Install nix packages
nix_packages = "\n".join([f"{pkg}" for pkg in packages["nix"]])
old_nix_packages = open(f"{HOME}/.config/home-manager/packages.nix").read()
new_nix_packages = re.sub(r"\[*\]", nix_packages + "\n]", old_nix_packages)
open(f"{HOME}/.config/home-manager/packages.nix", "w").write(new_nix_packages)
sp.run("nix run home-manager/master -- switch --flake ~/.config/home-manager -b backup", shell=True)

# Install apt packages
if platform == "ubuntu":
    apt_packages = " ".join([f"{pkg}" for pkg in packages["apt"]])
    cmd = f"sudo apt-get install -y {apt_packages}"
    sp.run(cmd, shell=True)

# Install other packages

# Install mise
for pkg in packages["mise"]:
    sp.run(pkg["command"], shell=True)
