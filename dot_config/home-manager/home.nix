{ inputs, pkgs, config, ... }:
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
  home.packages = (import ./packages.nix { inherit pkgs; }) ++ [
    pkgs.pkg-config
    pkgs.openssl
  ];
  programs.home-manager.enable = true;
  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/.environment/commands"
    "${config.home.homeDirectory}/.environment/commands/bio"
    "${config.home.homeDirectory}/.environment/commands/cli-utils"
    "${config.home.homeDirectory}/.environment/commands/internet"
    "${config.home.homeDirectory}/.environment/commands/notification"
    "${config.home.homeDirectory}/.environment/commands/nuvobio"
    "${config.home.homeDirectory}/.config/emacs/bin"
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      nix-pkgs = "vim ~/.config/home-manager/packages.nix && nix-update";
      emacs = "emacs -nw";
      emacsdaemon = "emacs --daemon";
      emacsa = "emacs -c -nw";
      vim = "nvim";
      ls = "eza";
      rsync = "rsync --progress -v"; # always use verbose mode
      activate = "source .venv/bin/activate";
      nix-update = "nix run home-manager/master -- switch --flake ~/.config/home-manager -b backup --impure";
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
      plugins = [ "git" "sudo" ];
      theme = "robbyrussell";
    };
    initContent = ''
      eval "$(ssh-agent -s)"
      eval "$(starship init zsh)"
      eval "$(mise activate zsh)"
      grep -slR "PRIVATE" ~/.ssh/ | xargs ssh-add -q
      . $HOME/.nix-profile/bin
      . $HOME/.tokens
    '';
  };

  systemd.user.sockets.podman = {
    Unit.Description = "Podman API Socket";
    Socket = {
      ListenStream = "%t/podman/podman.sock";
      SocketMode = "0660";
    };
    Install.WantedBy = [ "sockets.target" ];
  };

  systemd.user.services.podman = {
    Unit = {
      Description = "Podman API Service";
      Requires = [ "podman.socket" ];
      After = [ "podman.socket" ];
    };
    Service = {
      Type = "exec";
      KillMode = "process";
      ExecStart = "${pkgs.podman}/bin/podman system service";
    };
  };
  imports = [ inputs.nix-doom-emacs-unstraightened.homeModule ];


  # so docker-compat tools (docker-compose, testcontainers, etc.) find it
  home.sessionVariables.DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";

  programs.doom-emacs = {
    enable = true;
    doomDir = ./doom.d;          # your self-managed Doom config
    doomLocalDir = "${config.home.homeDirectory}/.local/share/nix-doom";
  };
}
