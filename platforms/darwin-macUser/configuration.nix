{lib, config, pkgs, inputs, ... }: 
let
  darwinmodulesPath = ../../modules/darwin;
in
{
  system.stateVersion = 7;

  # Define Hostname
  networking.hostName = lib.removeSuffix "\n" (builtins.readFile ../../hostname/darwin);
  
  imports = [
    #common modules
    (darwinmodulesPath + /system.nix)
    (darwinmodulesPath + /users.nix)
    (darwinmodulesPath + /homebrew.nix)
    (darwinmodulesPath + /home-manager.nix)
  ];
}
