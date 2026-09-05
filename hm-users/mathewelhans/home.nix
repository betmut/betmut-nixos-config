{config, configPath, inputs, hm-pkgs, pkgs-stable, lib, ... }: 
let
  config-files = lib.filesystem.listFilesRecursive ./config;
  hyprlandPath = "${config.home.homeDirectory}/betmut-nixos-config/desktop-environment/hyprland";
  
in
{
  imports = builtins.filter (file: lib.hasSuffix ".nix" file) config-files;
  home.stateVersion = "26.05";

  home.pointerCursor.enable = true;
  home.homeDirectory = "/home/mathewelhans";

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
    nodejs
    opencode
  ] ++ [
    pkgs-stable.warzone2100
  ];

  home.sessionVariables = {
    GIT_EDITOR = "vim";
    NIXOS_OZONE_WL = "1";
  };

  # Hyprland config files
  xdg.configFile = {
    "hypr/hyprland.lua".source = config.lib.file.mkOutOfStoreSymlink (
      hyprlandPath + "/hyprland.lua");
    "hypr/conf".source = config.lib.file.mkOutOfStoreSymlink (
      hyprlandPath + "/conf");
  };

  # Swappy config files
  xdg.configFile = {
    "swappy/config".source = config.lib.file.mkOutOfStoreSymlink (
      configPath + "/swappy/config");
  };
}