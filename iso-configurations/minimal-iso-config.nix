{config, pkgs, inputs, lib, ... }: 
let
  linuxmodulesPath = ../modules/linux;
  servicesPath = ../modules/services;
in
{
  users.users.nixos = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = ["users" "audio" "networkmanager" "video" "render"];
    initialPassword = "301103";
    initialHashedPassword = nixpkgs.lib.mkForce null;
  };
  
  imports = [

    (linuxmodulesPath + /kernel.nix)
    (linuxmodulesPath + /hardware.nix)
    (linuxmodulesPath + /networking.nix)
    (linuxmodulesPath + /programs-core.nix)
    (linuxmodulesPath + /system-basics.nix)

    (servicesPath + /ssh.nix)
    (servicesPath + /mac-hardware.nix)
  ];

  #Overwriting hostname value
  networking.hostName = lib.mkForce "arendelle";
}