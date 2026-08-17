{lib, config, pkgs, inputs, ... }: 
let
  linuxmodulesPath = ../../modules/linux;
  servicesPath = ../../modules/services;
in
{
  system.stateVersion = "26.05";

  # Define Hostname
  networking.hostName = lib.removeSuffix "\n" (builtins.readFile ../../hostname/nixos-install);

  imports = [
    #essential linux modules & services
    (linuxmodulesPath + /default.nix)
    (servicesPath + /default.nix)
    
    #essential settings
    ../../disks.nix
    ../../nix-settings.nix

    # you can modify the default configuration here and add 
    #your own modules, packages, and settings
    ./users.nix
    ./boot.nix
    ./packages.nix
    ./env-variable.nix
  ];
}