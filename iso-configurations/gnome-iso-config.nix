{config, modulesPath, ... }: {

  imports = [
    ./minimal-iso-config.nix
    (modulesPath + "/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix")
  ];
}