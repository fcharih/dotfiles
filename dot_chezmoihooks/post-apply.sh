#! /bin/bash
/nix/var/nix/profiles/default/bin/nix profile install nixpkgs#hello
/nix/var/nix/profiles/default/bin/nix run home-manager/master -- switch
