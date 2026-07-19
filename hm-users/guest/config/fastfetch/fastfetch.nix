{ pkgs, ... }:{

  programs.fastfetch.enable = true;

  #config files
  xdg.configFile = {
    "fastfetch/config.jsonc".source = ./config.jsonc;
  };
}