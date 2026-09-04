{config, hm-pkgs, lib, ...}: 
let
  swayncPath = ../../../../desktop-environment/swaync;
in
{
  services.swaync = {
    enable = true;
    package = hm-pkgs.swaynotificationcenter;
  };

  #config files
  xdg.configFile = {
    "swaync/config.json".source = lib.mkForce (swayncPath + "/config.json");
    "swaync/style.css".source = lib.mkForce (swayncPath + "/style.css");
  };
}