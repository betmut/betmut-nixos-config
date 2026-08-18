{config, pkgs, lib, ...}: 
let
  waybar-git = pkgs.callPackage ../../../../modules/packages/waybar-git.nix { };
in
{
  programs.waybar = {
    enable = true;
    package = waybar-git;
  };

  #config files
  xdg.configFile = {
    "waybar/config".source = ./config;
    "waybar/style.css".source = lib.mkForce ./style.css;
  };

  #Packages
  home.packages = with pkgs; [
    lm_sensors
  ];
}