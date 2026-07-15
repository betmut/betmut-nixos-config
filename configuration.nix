{config, pkgs, inputs, modulesPath, ... }: {

  system.stateVersion = "26.05";
  imports = [
    #modules
    ./modules/common.nix
    ./modules/linux.nix
    ./modules/networking.nix
    ./modules/fonts.nix
    ./modules/gaming.nix

    #services
    ./services/services.nix
    ./services/media-automation.nix
    ./services/power-alerts.nix

    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise = {
      automatic = true;
      dates = [ "20:00" ];
    };
  };
}
