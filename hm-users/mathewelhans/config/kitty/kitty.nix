{hm-pkgs, ...}: {

  programs.kitty = {
    enable = true;
    package = hm-pkgs.kitty;
  };

  #config files
  xdg.configFile = {
    "kitty/kitty.conf".source = ./kitty.conf;
    "kitty/gruvbox-kitty.conf".source = ./gruvbox-kitty.conf;
    "kitty/term_bell".source = ./term_bell;
  };

}