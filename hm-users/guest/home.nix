{config, hm-pkgs, lib, ... }: 
let
  config-files = lib.filesystem.listFilesRecursive ./config;
  system-wide-path = ../../desktop-environment;
in
{
  imports = builtins.filter (file: lib.hasSuffix ".nix" file) config-files;
  home.stateVersion = "26.05";

  home.pointerCursor.enable = true;
  home.homeDirectory = "/home/guest";
    
  #Packages
  home.packages = with hm-pkgs; [
    btop 
    cmatrix 
    brightnessctl 
    playerctl
    wireplumber

    kitty
    fastfetch
    yazi
    nodejs
  ];

  home.sessionVariables = {
    GIT_EDITOR = "vim";
  };

  # hyprland config files
  xdg.configFile = {
    "hypr/hyprland.lua".source = system-wide-path + "/hyprland/hyprland.lua";
    "hypr/conf".source = system-wide-path + "/hyprland/conf";
  };

  # wlogout config files
  xdg.configFile = {
    "wlogout/layout".source = system-wide-path + "/wlogout/layout";
    "wlogout/style.css".source = system-wide-path + "/wlogout/style.css";
    "wlogout/icons".source = system-wide-path + "/wlogout/icons";
  };

  # Swappy config files
  xdg.configFile = {
    "swappy/config".source = ./config/swappy/config;
  };
}
