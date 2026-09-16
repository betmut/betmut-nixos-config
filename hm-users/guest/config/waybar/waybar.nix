{config, pkgs, lib, ...}:
let
  waybar-git = pkgs.callPackage ../../../../modules/packages/waybar-git.nix { };
  waybarPath = ../../../../desktop-environment/waybar;
in
{
  programs.waybar = {
    enable = true;
    package = waybar-git;
  };

  #config files
  xdg.configFile = {
    "waybar/config".source = waybarPath + "/config.jsonc";
    "waybar/style.css".source = lib.mkForce (waybarPath + "/style.css");
  };

  #Packages
  home.packages = with pkgs; [
    lm_sensors
  ];

}