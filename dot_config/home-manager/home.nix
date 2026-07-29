{ pkgs, ... }:
let
  azure-cli-with-extensions = pkgs.azure-cli.withExtensions [
    pkgs.azure-cli-extensions.azure-devops
  ];
in
{
  home.username = "fcharih";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin then "/Users/fcharih" else "/home/fcharih";
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
    gh
    mise
    podman
    podman-compose
    buildah
    skopeo
    claude-code
    signal-cli
    pkg-config
    cmake
    gcc
    nushell
    android-tools
    libsixel
    android-tools
    terraform
    zellij
    timg
    emacs30
    emacsPackages.doom
    postgresql_18
    openssl
    cloudflared
    luarocks
    unzip
    rtorrent
    gvproxy
    netavark
    aardvark-dns
    slirp4netns
    fuse-overlayfs
    crun
  ];
  programs.home-manager.enable = true;
  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  xdg.configFile."containers/containers.conf".text = ''
    [engine]
    helper_binaries_dir = ["${pkgs.gvproxy}/bin"]

    [network]
    network_backend = "netavark"
  '';
}
