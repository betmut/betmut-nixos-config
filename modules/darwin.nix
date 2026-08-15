{config, pkgs, inputs, lib, ... }: {
  homebrew = {
    enable = true;
    casks = [
      "racket"
      "qutebrowser"
      "obsidian"
      "whatsapp"
      "gimp"
      "inkscape"
      "figma"
      "minecraft"
      "spotify"
      "capcut"
      "discord"
      "vlc"
      "warzone-2100"
      "virtualbox"
    ];
  };

  #dock configurations
  system.defaults = {

    dock = {
      autohide = true;
      largesize = 90;
      launchanim = true;
      magnification = true;
      mineffect = "scale";
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      "com.apple.trackpad.enableSecondaryClick" = true;
      "com.apple.trackpad.forceClick" = false;
      "com.apple.trackpad.scaling" = 1.3;
    };

    trackpad = {
      Dragging = true;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
    };
    
    controlcenter = {
      BatteryShowPercentage = true;
      FocusModes = true;
    };
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
  };

  system.activationScripts = {
    applications.text = let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
      pkgs.lib.mkForce 
          ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
          '';

    resetLaunchPad.text = 
      ''
      defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
      '';

  };   
}