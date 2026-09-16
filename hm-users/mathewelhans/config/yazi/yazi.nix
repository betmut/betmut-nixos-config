{config, lib, configPath, pkgs, ... }:{

  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
  };

  #config files
  xdg.configFile = {
    "yazi/theme.toml".source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink (configPath + "/yazi/theme.toml"));

    "yazi/flavors".source  = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink (configPath + "/yazi/flavors"));
  };
}