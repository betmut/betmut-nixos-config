{config, pkgs, lib, ... }: {
  # silent boot settings
  boot = {
    consoleLogLevel = 0; #shows only critical messages during boot
    kernelParams = [ 
      "quiet" #reduces routine kernel messages
      "udev.log_level=3" #suppressing lower-priority informational messages (still showing warnings)
    ];
  };
  
  # Enable plymouth
  boot.plymouth = {
    enable = true;
    theme = lib.mkForce "tribar";
  };
}
