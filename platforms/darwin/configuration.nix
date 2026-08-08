{config, pkgs, inputs, ... }: {

  system.stateVersion = "26.05";

  _module.args.pkgs-stable = import inputs.nixpkgs-stable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
  
  imports = [
    #common modules
    ../../modules/darwin.nix
  ];
}