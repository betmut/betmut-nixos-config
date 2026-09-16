{config, pkgs, lib, ...}:
let
  waybar-git = pkgs.callPackage ../../../../modules/packages/waybar-git.nix { };
  waybarPath = "${config.home.homeDirectory}/betmut-nixos-config/desktop-environment/waybar";
in
{
  programs.waybar = {
    enable = true;
    package = waybar-git;
  };

  #config files
  xdg.configFile = {
    "waybar/config.jsonc".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink (waybarPath + "/config.jsonc"));
    "waybar/style.css".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink (waybarPath + "/style.css"));
  };

  #Packages
  home.packages = with pkgs; [
    lm_sensors
  ];

}