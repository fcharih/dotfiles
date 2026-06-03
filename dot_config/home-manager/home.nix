{ pkgs, ... }:
{
  home.username = "fcharih";
  home.homeDirectory = "/home/fcharih";   # /Users/YOURUSER on macOS
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    ripgrep
    fd
    htop
    jq
    fzf
    neovim
    uv
    pyenv
    zsh
    rustc
    eza
    volta
    docker
    rootlesskit
    azure-cli
    azure-storage-azcopy
    starship
    oh-my-zsh
    _1password-cli
    chezmoi
    gh
  ];


  programs.git.settings = {
    enable = true;
    userName = "Francois Charih";
    userEmail = "francois@charih.ca";
  };

  programs.home-manager.enable = true;
programs.zsh = {
  enable = true;
initExtra = ''
  [ -f ~/.zshrc ] && source ~/.francois.zshrc
'';
  oh-my-zsh = {
    enable = true;
    plugins = [ "git" "sudo" "docker" ];
    theme = "robbyrussell";
  };
};
}
