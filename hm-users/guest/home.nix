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

   # Hyprlock config files
  xdg.configFile = {
    "hypr/hyprlock.conf".source = ./config/hyprlock/hyprlock.conf;
    "hypr/launch-hyprlock.sh".source = ./config/hyprlock/launch-hyprlock.sh;
    
    "hypr/wallpapers" = {
      source = ./config/hyprlock/wallpapers;
      recursive = true;
    };
    "hypr/scripts" = {
      source = ./config/hyprlock/scripts;
      recursive = true;
    };

    "hypr/assets" = {
      source = ./config/hyprlock/assets;
      recursive = true;
    };

    "hypr/assets/battery" = {
      source = ./config/hyprlock/assets/battery;
      recursive = true;
    };

    "hypr/assets/wifi" = {
      source = ./config/hyprlock/assets/wifi;
      recursive = true;
    };
  };
}
