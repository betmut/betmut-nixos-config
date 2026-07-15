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
