{config, pkgs, inputs, lib, ... }: {
  homebrew = {
    enable = true;
    casks = [
      "racket"
      "qutebrowser"
      "obsidian"
      "whatsapp"
      "gimp"
      "inkscape"
      "figma"
      "minecraft"
      "spotify"
      "capcut"
      "discord"
      "vlc"
      "warzone-2100"
      "virtualbox"
    ];
  };
}