{ config, pkgs, ... }: {
  services.mbpfan = {
    enable = true;
    aggressive = false;
    settings = {
      general = {
        low_temp = 63;   # Fans run at minimum speed below this
        high_temp = 66;  # Fan speed gradually ramps up above this
        max_temp = 86;   # Max fan speed reached here
      };
    };
  };
}