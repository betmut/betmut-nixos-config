{config, pkgs, ...}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };

  #config files
  xdg.configFile = {
    "waybar/config".source = ./config;
    "waybar/style.css".source = lib.mkForce ./style.css;
  };
}