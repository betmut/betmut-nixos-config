{config, pkgs, inputs, modulesPath, ... }: {

  nixpkgs.overlays = [ (final: prev: {
    inherit (prev.lixPackageSets.stable)
      nixpkgs-review
      nix-eval-jobs
      nix-fast-build
      colmena;
  }) ];

  nix.package = pkgs.lixPackageSets.stable.lix;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      extra-deprecated-features = "or-as-identifier";
      http-connections = 128;
      max-substitution-jobs = 128;
      substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store" # Shanghai Jiao Tong University - best for Asia
        "https://mirrors.ustc.edu.cn/nix-channels/store" # USTC backup mirror
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