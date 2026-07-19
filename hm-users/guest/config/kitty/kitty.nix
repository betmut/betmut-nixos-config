{pkgs, ...}: {

  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
  };

  #config files
  xdg.configFile = {
    "kitty/kitty.conf".source = ./kitty.conf;
    "kitty/gruvbox-kitty.conf".source = ./gruvbox-kitty.conf;
  };

}