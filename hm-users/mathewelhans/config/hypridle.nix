{config, pkgs, lib,...}: {

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "loginctl lock-session";    # lock before suspend
        after_sleep_cmd = "hyprctl dispatch dpms on";  # turn on screen after wake
      };
      
      listener = [
        {
          timeout = 300; # 5 minutes
          on-timeout = "brightnessctl -s set 10"; # Dim the screen
          on-resume = "brightnessctl -r";         # Restore brightness
        }
        {
          timeout = 600; # 10 minutes
          on-timeout = "brightnessctl -s set 0";
          on-resume = "brightnessctl -r";
        }
      ];
    };
  };
}