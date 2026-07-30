{pkgs, inputs, config, ...}: {

  #Creating Temporary Guest user
  systemd.tmpfiles.rules = [
    "R /home/guest - - - - -"   # Recursively remove the home folder on boot
    "d /home/guest 0700 guest users - -" # Recreate it fresh
  ];
}