{config, pkgs, inputs, modulesPath, ... }: {
  
  system.stateVersion = "26.05";

  _module.args.pkgs-stable = import inputs.nixpkgs-stable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };

  imports = [
    #common modules
    ./modules/common.nix
    ./stylix.nix
    ./disks.nix
    ./nix-settings.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
}
