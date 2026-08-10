{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    mkHome = system: home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      modules = [
        inputs.nix-doom-emacs-unstraightened.homeModule
        ./home.nix
      ];
      extraSpecialArgs = { inherit inputs; };
    };
  in {
    homeConfigurations = {
      fcharih            = mkHome "aarch64-darwin"; # default: your Mac
      "fcharih@linuxbox" = mkHome "x86_64-linux";    # rename to match `hostname` on that machine
    };
  };
}
