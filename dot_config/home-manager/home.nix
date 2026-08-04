{ pkgs, config, ... }:
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
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/.environment/commands"
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      vim = "nvim";
      ls = "eza";
      rsync = "rsync --progress -v"; # always use verbose mode
      activate = "source .venv/bin/activate";
      nix-update = "nix run home-manager/master -- switch --flake ~/.config/home-manager -b backup";
      oplogin = "eval \"$(op signin)\"";
      azlogin = "az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID";
      azcopylogin = "AZCOPY_SPA_CLIENT_SECRET=$AZURE_CLIENT_SECRET azcopy login --service-principal --application-id $AZURE_CLIENT_ID --tenant-id $AZURE_TENANT_ID";
    };
    history = {
      size = 10000;
      save = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
    };
    sessionVariables = {
      EDITOR = "nvim";
      TERM = "xterm-256color";
      CARGO_NET_GIT_FETCH_WITH_CLI = "true";
      PYTHONPATH = "$PYTHONPATH:${config.home.homeDirectory}/.environment/python";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "sudo" ];
      theme = "robbyrussell";
    };
    initExtra = ''
      eval "$(ssh-agent -s)"
      eval "$(starship init zsh)"
      eval "$(mise activate zsh)"
      grep -slR "PRIVATE" ~/.ssh/ | xargs ssh-add -q
      . $HOME/.nix-profile/bin
      . $HOME/.tokens
    '';
  };
}
