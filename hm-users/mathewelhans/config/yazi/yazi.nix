{ pkgs, ... }:{

  programs.yazi.enable = true;

  #config files
  xdg.configFile = {
    "yazi/theme.toml".source = ./theme.toml;
    "yazi/flavors".source  = ./flavors;
  };
}