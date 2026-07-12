{ pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi; 
    theme = lib.mkForce ./themes/gruvbox-dark-hard.rasi;
    terminal = "${pkgs.kitty}/bin/kitty";
    plugins = with pkgs; [
      rofi-calc
    ];

    extraConfig = {
      timeout = {
        action = "kb-cancel";
        delay = 0;
      };
      
      filebrowser = {
        directories-first = true;
        sorting-method = "name";
      };
      show-icons = true;
      drun-display-format = "{icon} <b>{name}</b> <span weight='light' size='small'><i>{generic}</i></span>";
      display-drun = "   Search ";
      sidebar-mode = true;
      modes = [ "drun" "window" "filebrowser" "calc"];
    };
  };
}
