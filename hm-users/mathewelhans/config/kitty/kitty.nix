{pkgs, ...}: {

  programs.kitty.enable = true;

  #config files
  xdg.configFile = {
    "kitty/kitty.conf".source = ./kitty.conf;
    "kitty/gruvbox-kitty.conf".source = ./gruvbox-kitty.conf;
  };

}