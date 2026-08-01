{config, pkgs, lib, ...}: {
  services.swaync = {
    enable = true;
    package = pkgs.swaynotificationcenter;
  };

  #config files
  xdg.configFile = {
    "swaync/config.json".source = lib.mkForce ./config.json;
    "swaync/style.css".source = lib.mkForce ./style.css;
  };
}