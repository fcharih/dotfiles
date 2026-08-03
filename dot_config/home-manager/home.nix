{ pkgs, ... }:
let
  azure-cli-with-extensions = pkgs.azure-cli.withExtensions [
    pkgs.azure-cli-extensions.azure-devops
    pkgs.azure-cli-extensions.ssh
  ];
in
{
  home.username = "fcharih";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin then "/Users/fcharih" else "/home/fcharih";
  home.stateVersion = "24.11";
  home.packages = import ./packages.nix { inherit pkgs; };
  programs.home-manager.enable = true;

  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile $HOME/.zshrc;
  };
}
