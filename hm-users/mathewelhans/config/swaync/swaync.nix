{config, hm-pkgs, lib, ...}: 
let
  swayncPath = "${config.home.homeDirectory}/betmut-nixos-config/desktop-environment/swaync";
in
{
  services.swaync = {
    enable = true;
    package = hm-pkgs.swaynotificationcenter;
  };

  #config files
  xdg.configFile = {
    "swaync/config.json".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink (swayncPath + "/config.json"));
    "swaync/style.css".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink (swayncPath + "/style.css"));
  };
}