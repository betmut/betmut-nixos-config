{ pkgs, inputs, config, ...}: {
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
}