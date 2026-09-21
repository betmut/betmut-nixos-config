{config, pkgs, lib, ... }: {
  # silent boot settings
  boot = {
    consoleLogLevel = 0; #shows only critical messages during boot
    initrd.verbose = false; #hides message during the very early stage of booting
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
