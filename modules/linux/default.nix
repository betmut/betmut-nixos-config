{ config, pkgs, ... }: {
  imports = [
    ./boot.nix
    ./display-manager.nix
    ./ephemeral-guest.nix
    ./fonts.nix
    ./gaming.nix
    ./hardware.nix
    ./kernel.nix
    ./networking.nix
    ./programs-core.nix
    ./security.nix
    ./system-basics.nix
    ./users.nix
  ];
}