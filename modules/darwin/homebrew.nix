{ inputs, config, ... }: {
  
  # Align homebrew taps config with nix-homebrew
  homebrew.taps = builtins.attrNames config.nix-homebrew.taps;

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "macUser";

    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };

    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    casks = [
      "racket"
    ];
  };
}