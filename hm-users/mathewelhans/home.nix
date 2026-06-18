{config, pkgs, lib, ... }: {

  imports = [
    ./config/vscode.nix
    ./config/vim.nix
    ./config/hypridle.nix
    ./config/hyprpaper.nix
    ./config/zsh.nix
  ];
  home.stateVersion = "25.11";

  #Packages
  home.packages = with pkgs; [
    vscode
    nodejs 
    python3 
    R  
    htop 
    cmatrix 
    spotify
    playerctl
    obsidian
    racket
    discord
    zoom-us
    eog
    zotero
    evince
    vlc
    mgba
    libreoffice
    warzone2100
    scrcpy
    android-tools
  ];
  home.sessionVariables = {
    GIT_EDITOR = "vim";
    NIXOS_OZONE_WL = "1";
  };

  #.config files
  xdg.configFile = {
    "hypr/hyprland.lua".source = ../../dotfiles/hyprland/hyprland.lua;
    "hypr/conf".source = ../../dotfiles/hyprland/conf;

  
    "kitty/kitty.conf".source = ../../dotfiles/kitty/kitty.conf;
    "kitty/gruvbox-kitty.conf".source = ../../dotfiles/kitty/gruvbox-kitty.conf;

    "yazi/theme.toml".source = ../../dotfiles/yazi/theme.toml;
    "yazi/flavors".source  = ../../dotfiles/yazi/flavors;

    "fastfetch/config.jsonc".source = ../../dotfiles/fastfetch/config.jsonc;
  };
  
  
}
