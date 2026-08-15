{lib, config, pkgs, inputs, ... }: {

  system.stateVersion = 7;

  # Define Hostname
  networking.hostName = lib.removeSuffix "\n" (builtins.readFile ../../hostname/darwin);
  
  imports = [
    #common modules
    ../../modules/darwin/users.nix
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/home-manager.nix
  ];
}
