{lib, hm-pkgs, ... }:{

  programs.yazi = {
    enable = true;
    package = hm-pkgs.yazi;
  };

  #config files
  xdg.configFile = {
    "yazi/theme.toml".source = lib.mkForce ./theme.toml;
    "yazi/flavors".source  = lib.mkForce ./flavors;
  };
}