{ pkgs, ... }:{

  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;
  };

  #config files
  xdg.configFile = {
    "fastfetch/config.jsonc".source = ./config.jsonc;
  };
}