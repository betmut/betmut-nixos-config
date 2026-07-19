{config, pkgs, inputs,...}:{
  imports = [
    ./hyprland/hyprland.nix
    ./display-manager.nix
  ];
}
