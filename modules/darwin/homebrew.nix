{darwin-username, inputs, config, ... }: {
  
  # Align homebrew taps config with nix-homebrew
  homebrew.taps = builtins.attrNames config.nix-homebrew.taps;

  nix-homebrew = {
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = builtins.currentSystem == "aarch64-darwin";
    user = darwin-username;

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
      "zoom"
      "visual-studio-code"
      "spotify"
      "obsidian"
      
    ];
  };
}