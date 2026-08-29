{config, hm-pkgs, pkgs, ...}: {

  services.gammastep = {
    enable = true;
    package = hm-pkgs.gammastep;
    provider = "geoclue2";
    tray = true;

    temperature = {
      day = 5500;
      night = 3700;
    };

    enableVerboseLogging = true;
  };
}