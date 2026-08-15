{lib, config, pkgs, inputs, ... }: {

  system.stateVersion = "26.05";

  _module.args.pkgs-stable = import inputs.nixpkgs-stable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };

  # Define Hostname
  networking.hostName = lib.removeSuffix "\n" (builtins.readFile ../../hostname/darwin);
  
  imports = [
    #common modules
    ../../modules/darwin.nix
    ../../nix-settings.nix
  ];
}
