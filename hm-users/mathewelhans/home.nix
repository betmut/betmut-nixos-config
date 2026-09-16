{config, configPath, inputs, pkgs, pkgs-stable, lib, ... }: 
let
  config-files = lib.filesystem.listFilesRecursive ./config;
  system-wide-path = "${config.home.homeDirectory}/betmut-nixos-config/desktop-environment";
  
in
{
  imports = builtins.filter (file: lib.hasSuffix ".nix" file) config-files;
  home.stateVersion = "26.05";

  home.pointerCursor.enable = true;
  home.homeDirectory = "/home/mathewelhans";

  #Packages
  home.packages = with pkgs; [
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
      system-wide-path + "/hyprland/hyprland.lua");
    "hypr/conf".source = config.lib.file.mkOutOfStoreSymlink (
      system-wide-path + "/hyprland/conf");
  };

  # wlogout config files
  xdg.configFile = {
    "wlogout/layout".source = config.lib.file.mkOutOfStoreSymlink (
      system-wide-path + "/wlogout/layout");
    "wlogout/style.css".source = config.lib.file.mkOutOfStoreSymlink (
      system-wide-path + "/wlogout/style.css");
    "wlogout/icons".source = config.lib.file.mkOutOfStoreSymlink (
      system-wide-path + "/wlogout/icons");
  };

  # Swappy config files
  xdg.configFile = {
    "swappy/config".source = config.lib.file.mkOutOfStoreSymlink (
      configPath + "/swappy/config");
  };
}