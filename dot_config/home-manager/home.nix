{ pkgs, ... }:
let
  azure-cli-with-extensions = pkgs.azure-cli.withExtensions [
    pkgs.azure-cli-extensions.azure-devops
  ];
in
{
  home.username = "fcharih";
  home.homeDirectory = "/home/fcharih";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
  ripgrep
fd
htop
jq
fzf
neovim
uv
zsh
eza
azure-cli-with-extensions
azure-storage-azcopy
starship
oh-my-zsh
_1password-cli
chezmoi
gh
mise
podman
podman-compose
buildah
skopeo
claude-code
signal-cli
  ];
  programs.home-manager.enable = true;
}
