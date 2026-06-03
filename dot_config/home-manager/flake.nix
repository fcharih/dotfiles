{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";        # or "aarch64-darwin" for Apple Silicon
    pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  in {
    homeConfigurations.fcharih = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
    };
  };
}
