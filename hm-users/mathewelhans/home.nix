{config, inputs, pkgs, lib, ... }: {

  imports = [
    ./config/vscode.nix
    ./config/vim/vim.nix
    ./config/hypridle.nix
    ./config/hyprpaper.nix
    ./config/zsh.nix
    ./config/rofi/rofi.nix
    ./config/waybar/waybar.nix
    ./config/swaync/swaync.nix
    ./config/kitty/kitty.nix
    ./config/fastfetch/fastfetch.nix
    ./config/yazi/yazi.nix
  ];
  home.stateVersion = "26.05";

  home.pointerCursor.enable = true;
  
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
    scrcpy
    android-tools
  ];

  home.sessionVariables = {
    GIT_EDITOR = "vim";
    NIXOS_OZONE_WL = "1";
  };

  #config files
  xdg.configFile = {
    "hypr/hyprland.lua".source = ../../desktop-environment/hyprland/hyprland.lua;
    "hypr/conf".source = ../../desktop-environment/hyprland/conf;
  };
}
