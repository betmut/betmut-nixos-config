{config, pkgs, ...}: {
  services.swaync = {
    enable = true;
    package = pkgs.swaynotificationcenter;
  };

  #config files
  xdg.configFile = {
    "swaync/config.json".source = ./config/swaync/config.json;
    "swaync/style.css".source = lib.mkForce ./config/swaync/style.css;
  };
}