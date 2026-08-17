{ config, pkgs, ... }: {
  imports = [
    ./boot.nix
    ./hardware.nix
    ./kernel.nix
    ./networking.nix
    ./programs-core.nix
    ./system-basics.nix
    ./ephemeral-guest.nix
  ];
}