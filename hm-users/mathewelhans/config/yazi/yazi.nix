{ pkgs, lib, ... }:{

  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
  };

  #config files
  xdg.configFile = {
    "yazi/theme.toml".source = lib.mkForce ./theme.toml;
    "yazi/flavors".source  = lib.mkForce ./flavors;
  };
}