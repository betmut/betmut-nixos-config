{config, inputs, hm-pkgs, pkgs-stable, lib, ... }: 
let
  config-files = lib.filesystem.listFilesRecursive ./config;
in
{
  imports = builtins.filter (file: lib.hasSuffix ".nix" file) config-files;
  home.stateVersion = "26.05";

  home.pointerCursor.enable = true;
  
  #Packages
  home.packages = with hm-pkgs; [
    vscode
    elan  
    btop 
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
    prismlauncher
    nodejs
    opencode
  ] ++ [
    pkgs-stable.warzone2100
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
