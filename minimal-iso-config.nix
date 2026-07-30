{config, pkgs, inputs, lib, ... }: 
let
  linuxmodulesPath = ./modules/linux;
  servicesPath = ./modules/services;
in
{
  imports = [
    (linuxmodulesPath + /kernel.nix)
    (linuxmodulesPath + /hardware.nix)
    (linuxmodulesPath + /networking.nix)
    (linuxmodulesPath + /programs-core.nix)
    (linuxmodulesPath + /system-basics.nix)

    (servicesPath + /ssh.nix)
    (servicesPath + /bittorrent-client.nix)
  ];
}