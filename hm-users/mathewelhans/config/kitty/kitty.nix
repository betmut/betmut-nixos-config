{hm-pkgs, config, lib, configPath, ...}: {

  programs.kitty = {
    enable = true;
    package = hm-pkgs.kitty;
  };

  #config files
  xdg.configFile = {
    "kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink (
      configPath + "/kitty/kitty.conf");
    "kitty/gruvbox-kitty.conf".source = config.lib.file.mkOutOfStoreSymlink (
      configPath + "/kitty/gruvbox-kitty.conf");

    "kitty/term_bell".source = config.lib.file.mkOutOfStoreSymlink (
      configPath + "/kitty/term_bell");
  };

}